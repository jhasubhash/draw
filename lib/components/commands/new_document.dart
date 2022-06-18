import 'package:draw/actions/actions.dart';
import 'package:draw/components/views/new_doc_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../models/app_state.dart';

const double height = 1000;
const double width = 1200;

void newDocument(BuildContext context) {
  showNewDocDialog(context);
  //StoreProvider.of<AppState>(context).dispatch(NewDocument(height, width));
  //StoreProvider.of<AppState>(context).dispatch(SetArtboardHeight(height));
  //StoreProvider.of<AppState>(context).dispatch(SetArtboardWidth(width));
}

Future<void> showNewDocDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return NewDocumentDialog();
    },
  );
}
