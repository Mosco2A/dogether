import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'contacts_widget.dart' show ContactsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactsModel extends FlutterFlowModel<ContactsWidget> {
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
