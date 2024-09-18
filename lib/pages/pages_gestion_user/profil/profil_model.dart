import '/composants/bottom_bar/bottom_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profil_widget.dart' show ProfilWidget;
import 'package:flutter/material.dart';

class ProfilModel extends FlutterFlowModel<ProfilWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for prenom widget.
  FocusNode? prenomFocusNode;
  TextEditingController? prenomTextController;
  String? Function(BuildContext, String?)? prenomTextControllerValidator;
  String? _prenomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'a5uv8xjr' /* Field is required */,
      );
    }

    if (val.length < 3) {
      return FFLocalizations.of(context).getText(
        'qhy68080' /* Ce sont des initiales, pas un ... */,
      );
    }
    if (val.length > 50) {
      return FFLocalizations.of(context).getText(
        '1q7bd4dy' /* C'est déja un beau prénom !!! */,
      );
    }

    return null;
  }

  // State field(s) for nom widget.
  FocusNode? nomFocusNode;
  TextEditingController? nomTextController;
  String? Function(BuildContext, String?)? nomTextControllerValidator;
  String? _nomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'su9zn1zc' /* Field is required */,
      );
    }

    if (val.length > 50) {
      return FFLocalizations.of(context).getText(
        '1u87rn66' /* C'est un nom Indien ? */,
      );
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
      return FFLocalizations.of(context).getText(
        'zr8smg2m' /* Field is required */,
      );
    }

    if (val.length < 12) {
      return FFLocalizations.of(context).getText(
        'zj533qbs' /* Un numéro c'est 10 chiffres ap... */,
      );
    }
    if (val.length > 12) {
      return FFLocalizations.of(context).getText(
        'v77ikzlz' /* Il faut enlever le 0 après le ... */,
      );
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
