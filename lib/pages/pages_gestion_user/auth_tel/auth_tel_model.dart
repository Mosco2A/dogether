import '/flutter_flow/flutter_flow_util.dart';
import 'auth_tel_widget.dart' show AuthTelWidget;
import 'package:flutter/material.dart';

class AuthTelModel extends FlutterFlowModel<AuthTelWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for prenom widget.
  FocusNode? prenomFocusNode;
  TextEditingController? prenomTextController;
  String? Function(BuildContext, String?)? prenomTextControllerValidator;
  String? _prenomTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'nq186o74' /* Entrez votre prénom */,
      );
    }

    if (val.length < 3) {
      return FFLocalizations.of(context).getText(
        '0cbw2n9s' /* Pas moins de 3 caratères */,
      );
    }
    if (val.length > 30) {
      return FFLocalizations.of(context).getText(
        'nycmc56y' /* Prénom limité à 30 caractères */,
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
        'tnem4uyp' /* Entrez votre nom */,
      );
    }

    if (val.length < 2) {
      return FFLocalizations.of(context).getText(
        'lkmhs45t' /* Pas moins de 2 caratères */,
      );
    }
    if (val.length > 40) {
      return FFLocalizations.of(context).getText(
        '55m3u75h' /* Prénom limité à 40 caractères */,
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
        'm2dhgrh6' /* Entrez un téléphone valide : +... */,
      );
    }

    if (val.length < 12) {
      return FFLocalizations.of(context).getText(
        'unjr4mus' /* Mini 12 caractères */,
      );
    }
    if (val.length > 12) {
      return FFLocalizations.of(context).getText(
        'gmrlnaxn' /* Limité à 12 caractères */,
      );
    }
    if (!RegExp('\\+33[6-7]\\d{8}').hasMatch(val)) {
      return FFLocalizations.of(context).getText(
        'h8w6ys27' /* Sous la forme : +33999999999 */,
      );
    }
    return null;
  }

  // Stores action output result for [Validate Form] action in Button widget.
  bool? resultValidateForm;

  @override
  void initState(BuildContext context) {
    prenomTextControllerValidator = _prenomTextControllerValidator;
    nomTextControllerValidator = _nomTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
  }

  @override
  void dispose() {
    prenomFocusNode?.dispose();
    prenomTextController?.dispose();

    nomFocusNode?.dispose();
    nomTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
