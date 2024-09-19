import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'creer_widget.dart' show CreerWidget;
import 'package:flutter/material.dart';

class CreerModel extends FlutterFlowModel<CreerWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - listContactFromPhoneBook] action in Button widget.
  String? contactsJson;
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
