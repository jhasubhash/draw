import 'package:draw/components/canvas_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions/actions.dart';
import '../models/app_state.dart';

class LayerManager {
  static final LayerManager _instance = LayerManager._internal();
  late List<Layer> _layers;
  late BuildContext context;

  factory LayerManager(context) {
    _instance.context = context;
    return _instance;
  }

  LayerManager._internal() {
    _layers = [];
    // initialization logic
  }

  void addLayer(Layer layer) {
    _layers.add(layer);
  }

  void removeLayer(int index) {
    _layers.removeAt(index);
  }

  List<Layer> getLayers() {
    List<Layer> layers =
        List<Layer>.from(StoreProvider.of<AppState>(context).state.layers);
    return layers;
  }

  Layer getActiveLayer() {
    Layer layer = StoreProvider.of<AppState>(context).state.activeLayer;
    return layer;
  }

  void setActiveLayer(Layer layer) {
    StoreProvider.of<AppState>(context).dispatch(SetActiveLayer(layer));
  }

  void setActiveLayerWithId(int id) {
    Layer layer = getLayerwithId(id);
    StoreProvider.of<AppState>(context).dispatch(SetActiveLayer(layer));
  }

  void setActiveLayerWithIndex(int id) {
    Layer layer = getLayerwithIndex(id);
    StoreProvider.of<AppState>(context).dispatch(SetActiveLayer(layer));
  }

  void setLayers(layers) {
    StoreProvider.of<AppState>(context).dispatch(SetLayers(layers));
  }

  Layer getLayerwithId(id) {
    final layers = getLayers();
    final index = layers.indexWhere((element) => element.layerId == id);
    if (index >= 0) {
      return layers[index];
    } else {
      return Layer(-1);
    }
  }

  Layer getBaseLayer() {
    final layers = getLayers();
    return layers.last;
  }

  Layer getLayerwithIndex(index) {
    final layers = getLayers();
    if (index >= 0 && index < layers.length) {
      return layers[index];
    } else {
      return Layer(-1);
    }
  }

  void modifyLayerWithId(id, pathDataList) {
    final layers = getLayers();
    final index = layers.indexWhere((element) => element.layerId == id);
    if (index >= 0) {
      layers[index].pathDataList = pathDataList;
    }
    setLayers(layers);
    setActiveLayerWithId(id);
  }

  Widget createLayers([Widget child = const SizedBox.expand()]) {
    for (var layer in _layers) {
      child = RepaintBoundary(
        child: CustomPaint(
          painter: layer.painter,
          child: child,
        ),
      );
    }
    return child;
  }
}
