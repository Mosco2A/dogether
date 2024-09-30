// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:fast_contacts/fast_contacts.dart'; // Import contacts
import 'package:permission_handler/permission_handler.dart'; // Permission handling
import 'dart:convert'; // For jsonDecode and jsonEncode

// Déclaration de la variable globale
List<Map<String, String>> maListeDeContacts = [];
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ContactsPage extends StatefulWidget {
  final String contactsJson;
  ContactsPage({required this.contactsJson});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    loadContacts(); // Charger les contacts au démarrage
  }

  void loadContacts() async {
    final String? contactsJson = widget.contactsJson;
    // Vider la liste avant de charger
    maListeDeContacts.clear();

    if (contactsJson != null) {
      try {
        List<dynamic> loadedContacts = jsonDecode(contactsJson);
        maListeDeContacts = List<Map<String, String>>.from(loadedContacts);
      } catch (e) {
        print('Erreur lors du chargement des contacts : $e');
      }
    }
  }

  // Vérifier si un numéro de téléphone existe dans la collection users
  Future<bool> _isPhoneNumberValidated(String phoneNumber) async {
    var querySnapshot = await _firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get();

    return querySnapshot
        .docs.isNotEmpty; // Retourne true si un utilisateur est trouvé
  }

  // Ajoute le contact à Firestore avec un identifiant aléatoire et vérifie s'il est un utilisateur validé
  Future<void> _addContactToFirestore(String name, String phone) async {
    String docId = _firestore.collection('myContacts').doc().id; // ID aléatoire

    // Vérifier si le numéro de téléphone est validé (existe dans la collection users)
    bool isValidated = await _isPhoneNumberValidated(phone);

    await _firestore.collection('myContacts').doc(docId).set({
      'name': name,
      'phone': phone,
      'validatedUser': isValidated, // Ajouter true ou false selon le résultat
    });
  }

  // Supprime un contact de Firestore en utilisant son ID de document
  Future<void> _removeContactFromFirestore(String docId) async {
    await _firestore.collection('myContacts').doc(docId).delete();
  }

  // Récupère l'ID du document correspondant au nom du contact
  Future<String?> _getContactDocId(String name) async {
    var querySnapshot = await _firestore
        .collection('myContacts')
        .where('name', isEqualTo: name)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id; // Retourne l'ID du document
    }
    return null; // Aucun document trouvé
  }

  String formatPhoneNumber(String phone) {
    // Supprimer tous les espaces avant tout traitement
    phone = phone.replaceAll(' ', '');

    // Appliquer les règles de formatage des numéros français
    if (phone.startsWith('06')) {
      return '+336' + phone.substring(2);
    } else if (phone.startsWith('07')) {
      return '+337' + phone.substring(2);
    }

    return phone; // Retourne le numéro sans espaces et formaté
  }

  @override
  Widget build(BuildContext context) {
    // Charger la liste des contacts au format JSON
    List<dynamic> contactsList = jsonDecode(widget.contactsJson);
    // Trier la liste des contacts par ordre alphabétique
    contactsList.sort((a, b) => a['displayName'].compareTo(b['displayName']));

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Fonctionnalité de recherche à ajouter ici
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: contactsList.length,
        itemBuilder: (context, index) {
          var contact = contactsList[index];
          List<String> validPhones = (contact['phones'] as List<dynamic>)
              .where((phone) =>
                  phone.startsWith('+337') ||
                  phone.startsWith('+336') ||
                  phone.startsWith('06') ||
                  phone.startsWith('07'))
              .map((phone) => phone.toString()) // Convertir en String
              .toList();

          // Ne pas afficher le contact s'il n'a pas de numéro valide
          if (validPhones.isEmpty) {
            return SizedBox.shrink(); // Ne rien afficher
          }

          String phoneToSave =
              validPhones.first; // Prendre le premier numéro valide
          String formattedPhone =
              formatPhoneNumber(phoneToSave); // Formater le numéro

          return FutureBuilder<String?>(
            // Attendre l'ID du document
            future: _getContactDocId(contact['displayName']),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              String? docId = snapshot.data;
              bool isInFirestore = docId != null;

              return ListTile(
                title: Text(contact['displayName']),
                subtitle: Text('Phone: $formattedPhone'),
                trailing: ElevatedButton(
                  onPressed: () async {
                    if (isInFirestore) {
                      // Si le contact est déjà dans Firestore, le supprimer
                      await _removeContactFromFirestore(docId!);
                    } else {
                      // Ajouter le contact s'il n'existe pas déjà
                      await _addContactToFirestore(
                          contact['displayName'], formattedPhone);
                    }

                    // Attendre la fin de l'opération avant de recharger et mettre à jour l'état
                    setState(() {
                      loadContacts(); // Recharge les contacts après modification
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInFirestore ? Colors.red : Colors.blue,
                  ),
                  child: Text(isInFirestore ? 'Supprimer' : 'Ajouter'),
                ),
                // Afficher si le contact est un utilisateur validé
                leading: FutureBuilder<bool>(
                  future: _isPhoneNumberValidated(formattedPhone),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    bool isValidatedUser = snapshot.data ?? false;
                    return Icon(
                      isValidatedUser ? Icons.check_circle : Icons.error,
                      color: isValidatedUser ? Colors.green : Colors.grey,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pop(); // Retour à la page précédente
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

// Fonction pour lister les contacts et naviguer vers la page de contacts
Future<void> listeContacts(BuildContext context) async {
  List<Map<String, dynamic>> contactsList = [];

  // Vérifier et demander les permissions
  PermissionStatus permissionStatus = await _getContactPermission();
  if (permissionStatus != PermissionStatus.granted) {
    // Si les permissions ne sont toujours pas accordées, quitter
    return;
  }

  try {
    // Récupérer les contacts après que les permissions aient été accordées
    List<Contact> contacts = await FastContacts.getAllContacts();
    for (var contact in contacts) {
      // Extraire uniquement les numéros de téléphone
      List<String> phoneNumbers = contact.phones.map((e) => e.number).toList();

      contactsList.add({
        'displayName': contact.displayName,
        'phones': phoneNumbers, // Remplacer par une liste de chaînes
        'emails': contact.emails.map((e) => e.address).toList(),
      });
    }

    String contactsJson = jsonEncode(contactsList);
    // Naviguer vers la page cible en passant le JSON
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsPage(contactsJson: contactsJson),
      ),
    );
  } catch (e) {
    print('Failed to get contacts: ${e.toString()}');
  }
}

// Fonction pour vérifier et demander les permissions de contacts
Future<PermissionStatus> _getContactPermission() async {
  // Vérifier si la permission a déjà été accordée
  var status = await Permission.contacts.status;

  if (status.isDenied || status.isPermanentlyDenied) {
    // Demander à l'utilisateur s'il a refusé ou refusé de façon permanente
    PermissionStatus newStatus = await Permission.contacts.request();

    if (newStatus.isPermanentlyDenied) {
      // Si refus permanent, ouvrir les paramètres pour l'autoriser manuellement
      await openAppSettings();
    }
    return newStatus;
  }

  return status;
}
