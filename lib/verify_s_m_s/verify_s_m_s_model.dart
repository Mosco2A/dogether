import '/flutter_flow/flutter_flow_util.dart';
import 'verify_s_m_s_widget.dart' show VerifySMSWidget;
import 'package:flutter/material.dart';

class VerifySMSModel extends FlutterFlowModel<VerifySMSWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for phone-Number widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();
  }
}
