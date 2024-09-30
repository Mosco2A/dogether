import '/auth/firebase_auth/auth_util.dart';
import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:math';
import 'profil_widget.dart' show ProfilWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProfilModel extends FlutterFlowModel<ProfilWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for prenom widget.
  FocusNode? prenomFocusNode;
  TextEditingController? prenomTextController;
  String? Function(BuildContext, String?)? prenomTextControllerValidator;
  String? _prenomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 3) {
      return 'Ce sont des initiales, pas un prénom!';
    }
    if (val.length > 50) {
      return 'C\'est déja un beau prénom !!!';
    }

    return null;
  }

  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomTextController;
  String? Function(BuildContext, String?)? nomTextControllerValidator;
  String? _nomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length > 50) {
      return 'C\'est un nom Indien ?';
    }

    return null;
  }

  // State field(s) for phone-Number widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (val.length < 12) {
      return 'Un numéro c\'est 10 chiffres après +indicatif';
    }
    if (val.length > 12) {
      return 'Il faut enlever le 0 après le +33';
    }

    return null;
  }

  // Model for bottomBar component.
  late BottomBarModel bottomBarModel;

  @override
  void initState(BuildContext context) {
    prenomTextControllerValidator = _prenomTextControllerValidator;
    nomTextControllerValidator = _nomTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    bottomBarModel = createModel(context, () => BottomBarModel());
  }

  @override
  void dispose() {
    prenomFocusNode?.dispose();
    prenomTextController?.dispose();

    nomFocusNode?.dispose();
    nomTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    bottomBarModel.dispose();
  }
}
