import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'recues_widget.dart' show RecuesWidget;
import 'package:flutter/material.dart';

class RecuesModel extends FlutterFlowModel<RecuesWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for bottomBar component.
  late BottomBarModel bottomBarModel;

  @override
  void initState(BuildContext context) {
    bottomBarModel = createModel(context, () => BottomBarModel());
  }

  @override
  void dispose() {
    bottomBarModel.dispose();
  }
}
