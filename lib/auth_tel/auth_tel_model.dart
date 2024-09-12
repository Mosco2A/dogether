import '/flutter_flow/flutter_flow_util.dart';
import 'auth_tel_widget.dart' show AuthTelWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthTelModel extends FlutterFlowModel<AuthTelWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for phone-Number widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  final phoneNumberMask = MaskTextInputFormatter(mask: '##########');
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
