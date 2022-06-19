import 'dart:convert';
import 'dart:io';

import 'package:draw/components/commands/new_document.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../actions/actions.dart';
import '../../models/app_state.dart';
import '../canvas_data.dart';
import '../layer_manager.dart';

void open(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    File file = File(result.files.single.path!);
    var content = await file.readAsString();
    var jsonContent = jsonDecode(content);
    var data = jsonDecode(jsonContent['layers']);
    double artboardHeight = jsonContent['height'];
    double artboardWidth = jsonContent['width'];

    //print(data);
    List<Layer> layers = [];
    for (var layerData in data) {
      layers.add(Layer.fromJson(layerData));
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
  List<Layer> layers = LayerManager(context).getLayers();
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
  String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: 'Please select an output file:',
    fileName: 'output.json',
    allowedExtensions: ['json'],
  );
  if (outputFile == null) {
    // User canceled the picker
    return;
  }
  final file = File(outputFile);
  file.writeAsString(outData);
}
