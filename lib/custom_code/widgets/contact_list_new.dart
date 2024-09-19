// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactListNew extends StatefulWidget {
  const ContactListNew({
    Key? key,
    this.width,
    this.height,
    this.callBackAction,
    this.usersList,
    this.callBackActionNoContain,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Future<dynamic> Function()? callBackAction;
  final List<UsersRecord>? usersList;
  final Future<dynamic> Function()? callBackActionNoContain;

  @override
  _ContactListNewState createState() => _ContactListNewState();
}

class _ContactListNewState extends State<ContactListNew> {
  late List<Contact> _contacts;
  bool _permissionDenied = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _checkAndRequestPermission();
  }

  Future<void> _checkAndRequestPermission() async {
    final newStatus = await Permission.contacts.request();

    if (newStatus.isGranted) {
      _loadContacts();
    } else {
      setState(() {
        _permissionDenied = true;
      });
    }
  }

  Future<void> _loadContacts() async {
    setState(() {
      _loading = true;
    });
    Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts.toList();

      // Sort the contacts list to show contacts in the usersList first
      _contacts.sort((a, b) {
        String aPhoneNumber = a.phones!.isNotEmpty
            ? a.phones!.first.value ?? ''
            : 'No phone number';
        String bPhoneNumber = b.phones!.isNotEmpty
            ? b.phones!.first.value ?? ''
            : 'No phone number';

        bool aIsInUserList =
            widget.usersList?.any((user) => user.phoneNumber == aPhoneNumber) ??
                false;
        bool bIsInUserList =
            widget.usersList?.any((user) => user.phoneNumber == bPhoneNumber) ??
                false;

        if (aIsInUserList && !bIsInUserList) {
          return -1;
        } else if (!aIsInUserList && bIsInUserList) {
          return 1;
        } else {
          return 0;
        }
      });

      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: _permissionDenied
          ? Center(
              child: ElevatedButton(
                onPressed: _checkAndRequestPermission,
                child: Text('Allow access to contacts'),
              ),
            )
          : _loading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: _contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = _contacts[index];
                    String phoneNumber = contact.phones!.isNotEmpty
                        ? contact.phones!.first.value ?? ''
                        : 'No phone number';

                    // Check if the contact is in the userList
                    final isInUserList = widget.usersList
                            ?.any((user) => user.phoneNumber == phoneNumber) ??
                        false;

                    return ListTile(
                      leading:
                          (contact.avatar != null && contact.avatar!.isNotEmpty)
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(contact.avatar!),
                                )
                              : CircleAvatar(
                                  child: Text(contact.initials()),
                                ),
                      title: Text(contact.displayName ?? 'Unknown'),
                      subtitle: Text(phoneNumber),
                      trailing: isInUserList
                          ? Icon(Icons.circle_sharp,
                              color: FlutterFlowTheme.of(context).primary)
                          : null, // Add a trailing icon if the contact is in the userList
                      onTap: () {
                        // Set the PhoneNumber in the FFAppState
                        FFAppState().PhoneNumber = phoneNumber;

                        if (isInUserList) {
                          if (widget.callBackAction != null) {
                            widget.callBackAction!.call();
                          }
                        } else {
                          if (widget.callBackActionNoContain != null) {
                            widget.callBackActionNoContain!.call();
                          }
                        }
                      },
                    );
                  },
                ),
    );
  }
}
