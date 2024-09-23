import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_invitation_widget.dart' show CreateInvitationWidget;
import 'package:flutter/material.dart';

class CreateInvitationModel extends FlutterFlowModel<CreateInvitationWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for Titre widget.
  FocusNode? titreFocusNode;
  TextEditingController? titreTextController;
  String? Function(BuildContext, String?)? titreTextControllerValidator;
  String? _titreTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Merci de saisir un titre';
    }

    if (val.length < 5) {
      return '5 caractères minimum';
    }
    if (val.length > 30) {
      return '20 caractère maximum';
    }

    return null;
  }

  // State field(s) for Type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;
  // State field(s) for Detail widget.
  FocusNode? detailFocusNode;
  TextEditingController? detailTextController;
  String? Function(BuildContext, String?)? detailTextControllerValidator;
  String? _detailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Merci d\'ajouter un message de contexte';
    }

    if (val.length < 10) {
      return '10 caractères minimum';
    }
    if (val.length > 200) {
      return '200 Max';
    }

    return null;
  }

  // State field(s) for DateInvit widget.
  DateTimeRange? dateInvitSelectedDay;
  // State field(s) for HH widget.
  FocusNode? hhFocusNode;
  TextEditingController? hhTextController;
  String? Function(BuildContext, String?)? hhTextControllerValidator;
  String? _hhTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Saisir une heure entre 00 et 23';
    }

    if (val.length < 2) {
      return 'Saisir une heure entre 00 et 23';
    }
    if (val.length > 2) {
      return 'Saisir une heure entre 00 et 23';
    }
    if (!RegExp('(0[0-9]|1[0-9]|2[0-3])').hasMatch(val)) {
      return 'Saisir une heure entre 00 et 23';
    }
    return null;
  }

  // State field(s) for MM widget.
  FocusNode? mmFocusNode;
  TextEditingController? mmTextController;
  String? Function(BuildContext, String?)? mmTextControllerValidator;
  String? _mmTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Saisir des minutes entre 00 et 59';
    }

    if (val.length < 2) {
      return 'Saisir des minutes entre 00 et 59';
    }
    if (val.length > 2) {
      return 'Saisir des minutes entre 00 et 59';
    }
    if (!RegExp('([0-5][0-9])').hasMatch(val)) {
      return 'Saisir des minutes entre 00 et 59';
    }
    return null;
  }

  // State field(s) for NumDuree widget.
  String? numDureeValue;
  FormFieldController<String>? numDureeValueController;
  // State field(s) for JouH widget.
  String? jouHValue;
  FormFieldController<String>? jouHValueController;
  // State field(s) for Checkbox widget.
  Map<MyContactsRecord, bool> checkboxValueMap = {};
  List<MyContactsRecord> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Validate Form] action in Button widget.
  bool? outForm;
  // Stores action output result for [Backend Call - Create Document] action in Button widget.
  InvitationsEmisesRecord? createdDocument;

  @override
  void initState(BuildContext context) {
    titreTextControllerValidator = _titreTextControllerValidator;
    detailTextControllerValidator = _detailTextControllerValidator;
    dateInvitSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
    hhTextControllerValidator = _hhTextControllerValidator;
    mmTextControllerValidator = _mmTextControllerValidator;
  }

  @override
  void dispose() {
    titreFocusNode?.dispose();
    titreTextController?.dispose();

    detailFocusNode?.dispose();
    detailTextController?.dispose();

    hhFocusNode?.dispose();
    hhTextController?.dispose();

    mmFocusNode?.dispose();
    mmTextController?.dispose();
  }
}
