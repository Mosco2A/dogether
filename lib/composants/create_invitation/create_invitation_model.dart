import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'create_invitation_widget.dart' show CreateInvitationWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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

    if (val.length < 4) {
      return '4 caractères minimum';
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

  // Stores action output result for [Firestore Query - Query a collection] action in Checkbox widget.
  int? phoneExist;
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
