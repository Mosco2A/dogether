import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/permissions_util.dart';
import 'accueil_widget.dart' show AccueilWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
