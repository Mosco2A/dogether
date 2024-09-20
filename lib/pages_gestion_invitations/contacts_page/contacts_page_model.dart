import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'contacts_page_widget.dart' show ContactsPageWidget;
import 'package:flutter/material.dart';

class ContactsPageModel extends FlutterFlowModel<ContactsPageWidget> {
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