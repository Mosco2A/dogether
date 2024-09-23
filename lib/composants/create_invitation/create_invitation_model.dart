import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_invitation_widget.dart' show CreateInvitationWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreateInvitationModel extends FlutterFlowModel<CreateInvitationWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  // State field(s) for DateInvit widget.
  DateTimeRange? dateInvitSelectedDay;
  // State field(s) for HeureDebut widget.
  FocusNode? heureDebutFocusNode;
  TextEditingController? heureDebutTextController;
  final heureDebutMask =
      MaskTextInputFormatter(mask: '([01][0-9]|2[0-3]):[0-5][0-9]');
  String? Function(BuildContext, String?)? heureDebutTextControllerValidator;
  // State field(s) for NumDuree widget.
  String? numDureeValue;
  FormFieldController<String>? numDureeValueController;
  // State field(s) for TypeDuree widget.
  String? typeDureeValue;
  FormFieldController<String>? typeDureeValueController;
  // State field(s) for Checkbox widget.
  Map<MyContactsRecord, bool> checkboxValueMap = {};
  List<MyContactsRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // State field(s) for CalendLimit widget.
  DateTimeRange? calendLimitSelectedDay;
  // State field(s) for HeureFin widget.
  FocusNode? heureFinFocusNode;
  TextEditingController? heureFinTextController;
  final heureFinMask =
      MaskTextInputFormatter(mask: '([01][0-9]|2[0-3]):[0-5][0-9]');
  String? Function(BuildContext, String?)? heureFinTextControllerValidator;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  InvitationsEmisesRecord? createdDocument;

  @override
  void initState(BuildContext context) {
    dateInvitSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    calendLimitSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    textFieldFocusNode1?.dispose();
    textController1?.dispose();

    textFieldFocusNode2?.dispose();
    textController2?.dispose();

    heureDebutFocusNode?.dispose();
    heureDebutTextController?.dispose();

    heureFinFocusNode?.dispose();
    heureFinTextController?.dispose();
  }
}
