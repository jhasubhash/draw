import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../canvas_data.dart';
import '../layer_manager.dart';

void open(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    File file = File(result.files.single.path!);
    var content = await file.readAsString();
    var data = jsonDecode(content);
    //print(data);
    List<Layer> layers = [];
    for (var layerData in data) {
      layers.add(Layer.fromJson(layerData));
    }

    // ignore: use_build_context_synchronously
    LayerManager(context).setLayers(layers);
    // ignore: use_build_context_synchronously
    LayerManager(context).setActiveLayer(layers.last);
  }
}

void save(BuildContext context) async {
  List<Layer> layers = LayerManager(context).getLayers();
  var content = jsonEncode(layers);
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
  file.writeAsString(content);
}
