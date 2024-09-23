import '/backend/backend.dart';
import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'accueil_widget.dart' show AccueilWidget;
import 'package:flutter/material.dart';

class AccueilModel extends FlutterFlowModel<AccueilWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Firestore Query - Query a collection] action in Accueil widget.
  UsersRecord? queryUsers;
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
