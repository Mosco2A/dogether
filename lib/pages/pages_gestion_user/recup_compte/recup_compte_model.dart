import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'recup_compte_widget.dart' show RecupCompteWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RecupCompteModel extends FlutterFlowModel<RecupCompteWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for gauche widget.
  FocusNode? gaucheFocusNode;
  TextEditingController? gaucheTextController;
  final gaucheMask = MaskTextInputFormatter(mask: 'AAAAAA');
  String? Function(BuildContext, String?)? gaucheTextControllerValidator;
  // State field(s) for droite widget.
  FocusNode? droiteFocusNode;
  TextEditingController? droiteTextController;
  final droiteMask = MaskTextInputFormatter(mask: '######');
  String? Function(BuildContext, String?)? droiteTextControllerValidator;
  // State field(s) for recupPhoneNumber widget.
  FocusNode? recupPhoneNumberFocusNode;
  TextEditingController? recupPhoneNumberTextController;
  String? Function(BuildContext, String?)?
      recupPhoneNumberTextControllerValidator;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  int? queryMyId;
  // Stores action output result for [Firestore Query - Query a collection] action in Button widget.
  UsersRecord? queryResultContain;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    gaucheFocusNode?.dispose();
    gaucheTextController?.dispose();

    droiteFocusNode?.dispose();
    droiteTextController?.dispose();

    recupPhoneNumberFocusNode?.dispose();
    recupPhoneNumberTextController?.dispose();
  }
}
