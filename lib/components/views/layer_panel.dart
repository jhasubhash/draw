import 'package:draw/actions/actions.dart';
import 'package:draw/components/layer_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../models/app_state.dart';
import '../canvas_data.dart';

class LayerPanel extends StatefulWidget {
  LayerPanel({Key? key}) : super(key: key);

  @override
  State<LayerPanel> createState() => _LayerPanelState();
}

class LayerInfo {
  late Layer activeLayer;
  late List<Layer> layers;
  LayerInfo(this.activeLayer, this.layers);
}

class _LayerPanelState extends State<LayerPanel> {
  int nextLayerId = 1;

  void addLayer() {
    Layer layer = Layer(nextLayerId++);
    List<Layer> layers = LayerManager(context).getLayers();
    Layer activeLayer = LayerManager(context).getActiveLayer();
    if (activeLayer.layerId == -1) {
      print("no active layer");
      layers.insert(0, layer);
    } else {
      int idx = 0;
      for (idx = 0; idx < layers.length; idx += 1) {
        if (layers[idx].layerId == activeLayer.layerId) break;
      }
      if (idx == layers.length) return;
      layers.insert(idx, layer);
    }
    LayerManager(context).setLayers(layers);
    LayerManager(context).setActiveLayer(layer);
  }

  void printLayer(layers) {
    for (int idx = 0; idx < layers.length; idx += 1) {
      print("layer index ${idx} and layer id: ${layers[idx].layerId}");
    }
  }

  void removeLayer() {
    List<Layer> layers = LayerManager(context).getLayers();
    Layer activeLayer = LayerManager(context).getActiveLayer();
    int idx = 0;
    if (activeLayer.layerId == -1 || activeLayer.layerId == 0) {
      // no active layer or base layer
      print("no active layer");
      return;
    } else {
      for (idx = 0; idx < layers.length; idx += 1) {
        if (layers[idx].layerId == activeLayer.layerId) break;
      }
      if (idx < layers.length) {
        layers.removeAt(idx);
      } else {
        print("no layer with this id found ${activeLayer.layerId}");
      }
    }
    LayerManager(context).setLayers(layers);
    LayerManager(context).setActiveLayerWithIndex(idx - 1);
  }

  void reorderLayer(layers, int oldIndex, int newIndex) {
    List<Layer> newLayers = List<Layer>.from(layers);
    if (oldIndex == layers.length - 1 || newIndex == layers.length) return;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    Layer item = newLayers.removeAt(oldIndex);
    newLayers.insert(newIndex, item);
    StoreProvider.of<AppState>(context).dispatch(SetLayers(newLayers));
    LayerManager(context).setActiveLayerWithIndex(newIndex);
  }

  void onLayerTap(layer) {
    StoreProvider.of<AppState>(context).dispatch(SetActiveLayer(layer));
  }

  String getLayerText(Layer layer) {
    if (layer.layerId == LayerManager(context).getBaseLayer().layerId) {
      return "Background";
    }
    return "Layer ${layer.layerId}";
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LayerInfo>(
        converter: (store) =>
            LayerInfo(store.state.activeLayer, store.state.layers),
        builder: (BuildContext context, LayerInfo layerInfo) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 20, top: 20),
                child: const Text(
                  "Layers",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                width: double.infinity,
                height: 150,
                child: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    canvasColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: ReorderableListView(
                    buildDefaultDragHandles: false,
                    children: <Widget>[
                      for (int index = 0;
                          index < layerInfo.layers.length;
                          index++)
                        Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateX(-0.8),
                          alignment: FractionalOffset.center,
                          key: Key('$index'),
                          child: Container(
                            color: Colors.black12,
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            child: ReorderableDragStartListener(
                              index: index,
                              child: Material(
                                type: MaterialType.transparency,
                                child: ListTile(
                                  dense: true,
                                  visualDensity: VisualDensity.compact,
                                  textColor: Colors.white,
                                  selectedColor: Colors.white,
                                  style: ListTileStyle.list,
                                  selectedTileColor:
                                      const Color.fromARGB(255, 53, 53, 53),
                                  hoverColor:
                                      const Color.fromARGB(255, 53, 53, 53),
                                  focusColor:
                                      const Color.fromARGB(255, 53, 53, 53),
                                  key: Key('$index'),
                                  selected: layerInfo.activeLayer.layerId ==
                                      layerInfo.layers[index].layerId,
                                  title: Text(
                                      getLayerText(layerInfo.layers[index])),
                                  onTap: () {
                                    onLayerTap(layerInfo.layers[index]);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                    onReorder: (int oldIndex, int newIndex) {
                      reorderLayer(layerInfo.layers, oldIndex, newIndex);
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        addLayer();
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: layerInfo.activeLayer.layerId > 0
                          ? () {
                              removeLayer();
                            }
                          : null,
                      icon: const Icon(Icons.remove)),
                ],
              )
            ],
          );
        });
  }
}
