import '/backend/backend.dart';
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
  // State field(s) for TypeList widget.
  String? typeListValue;
  FormFieldController<String>? typeListValueController;
  // State field(s) for TypeAutre widget.
  FocusNode? typeAutreFocusNode;
  TextEditingController? typeAutreTextController;
  String? Function(BuildContext, String?)? typeAutreTextControllerValidator;
  String? _typeAutreTextControllerValidator(BuildContext context, String? val) {
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

  DateTime? datePicked;
  // State field(s) for Duree widget.
  String? dureeValue;
  FormFieldController<String>? dureeValueController;
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
    typeAutreTextControllerValidator = _typeAutreTextControllerValidator;
    detailTextControllerValidator = _detailTextControllerValidator;
  }

  @override
  void dispose() {
    titreFocusNode?.dispose();
    titreTextController?.dispose();

    typeAutreFocusNode?.dispose();
    typeAutreTextController?.dispose();

    detailFocusNode?.dispose();
    detailTextController?.dispose();
  }
}
