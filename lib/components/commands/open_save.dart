import 'dart:convert';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:universal_html/html.dart' as html;
import 'dart:io';

import 'package:draw/components/commands/new_document.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../canvas_data.dart' as canvasData;
import '../layer_manager.dart';
import '../painter/path_painter.dart';

void open(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: "Pick Art",
    allowedExtensions: ['json'],
    type: FileType.custom,
  );
  String content = "";
  if (result != null) {
    if (kIsWeb) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      content = utf8.decode(fileBytes!);
    } else {
      File file = File(result.files.single.path!);
      content = await file.readAsString();
    }
    var jsonContent = jsonDecode(content);
    var data = jsonDecode(jsonContent['layers']);
    double artboardHeight = jsonContent['height'];
    double artboardWidth = jsonContent['width'];

    //print(data);
    List<canvasData.Layer> layers = [];
    for (var layerData in data) {
      layers.add(canvasData.Layer.fromJson(layerData));
    }

    // ignore: use_build_context_synchronously
    StoreProvider.of<AppState>(context)
        .dispatch(NewDocument(artboardHeight, artboardWidth));
    // ignore: use_build_context_synchronously
    LayerManager(context).setLayers(layers);
    // ignore: use_build_context_synchronously
    LayerManager(context).setActiveLayer(layers.last);
  }
}

void save(BuildContext context) async {
  List<canvasData.Layer> layers = LayerManager(context).getLayers();
  double artboardHeight =
      StoreProvider.of<AppState>(context).state.artboardHeight;
  double artboardWidth =
      StoreProvider.of<AppState>(context).state.artboardWidth;
  var content = jsonEncode(layers);
  var data = {
    'layers': content,
    'height': artboardHeight,
    'width': artboardWidth,
  };
  var outData = jsonEncode(data);
  //print(content);
  if (kIsWeb) {
    final anchor = html.AnchorElement(href: "data:application/json,$outData")
      ..setAttribute("download", "art.json")
      ..click();
  } else {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Art:',
      fileName: 'output.json',
      allowedExtensions: ['json'],
      type: FileType.custom,
    );
    if (outputFile == null) {
      // User canceled the picker
      return;
    }
    final file = File(outputFile);
    file.writeAsString(outData);
  }
}

void saveAsPng(BuildContext context) async {
  final PictureRecorder recorder = PictureRecorder();
  List<canvasData.Layer> layers = LayerManager(context).getLayers();
  double artboardHeight =
      StoreProvider.of<AppState>(context).state.artboardHeight;
  double artboardWidth =
      StoreProvider.of<AppState>(context).state.artboardWidth;
  Size size = Size(artboardWidth, artboardHeight);
  PathPainter(context, layers).paint(Canvas(recorder), size);
  final Picture picture = recorder.endRecording();
  final img =
      await picture.toImage(artboardWidth.toInt(), artboardHeight.toInt());
  final byteData = await img.toByteData(format: ImageByteFormat.png);

  if (kIsWeb) {
    final blob = html.Blob(<dynamic>[byteData], 'application/octet-stream');
    final anchor =
        html.AnchorElement(href: html.Url.createObjectUrlFromBlob(blob))
          ..setAttribute("download", "art.png")
          ..click();
  } else {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Art:',
      fileName: 'output.png',
      allowedExtensions: ['png'],
      type: FileType.custom,
    );
    if (outputFile == null) {
      // User canceled the picker
      return;
    }
    final file = File(outputFile);
    final buffer = byteData!.buffer;
    file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}
