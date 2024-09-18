import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['fr', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? frText = '',
    String? enText = '',
  }) =>
      [frText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // AuthTel
  {
    'kquxcdgb': {
      'fr': 'DoGether',
      'en': '',
    },
    'opp2vsk6': {
      'fr': 'Connexion par téléphone',
      'en': '',
    },
    'xxzbadyb': {
      'fr':
          'Vous n\'avez besoin que d\'un numéro de téléphone pour vous inscrire (ou vous connecter si vous avez déja un compte).',
      'en': '',
    },
    'q2hqbeyn': {
      'fr':
          'Vous avez déja un compte. Vous ne pouvez en modifier ses attribut qu\'après connexion.',
      'en': '',
    },
    'ogigw7yu': {
      'fr': 'Prénom',
      'en': '',
    },
    '3dqqfj7x': {
      'fr': 'Saisissez votre prénom',
      'en': '',
    },
    't2egpk8k': {
      'fr': 'Nom ou pseudo',
      'en': '',
    },
    'l1cn1sfh': {
      'fr': 'Saisissez votre nom ou votre pseudo',
      'en': '',
    },
    'vtj2tu1p': {
      'fr': 'Téléphone',
      'en': '',
    },
    'igknfcle': {
      'fr': 'Saisissez un numéro type; +33611459151',
      'en': '',
    },
    'n84c2vrn': {
      'fr': 'Connexion',
      'en': '',
    },
    'nq186o74': {
      'fr': 'Entrez votre prénom',
      'en': '',
    },
    '0cbw2n9s': {
      'fr': 'Pas moins de 3 caratères',
      'en': '',
    },
    'nycmc56y': {
      'fr': 'Prénom limité à 30 caractères',
      'en': '',
    },
    't4xjkdht': {
      'fr': 'Entrez votre prénom',
      'en': '',
    },
    'tnem4uyp': {
      'fr': 'Entrez votre nom',
      'en': '',
    },
    'lkmhs45t': {
      'fr': 'Pas moins de 2 caratères',
      'en': '',
    },
    '55m3u75h': {
      'fr': 'Prénom limité à 40 caractères',
      'en': '',
    },
    '5300f0p8': {
      'fr': 'Entrez votre nom',
      'en': '',
    },
    'm2dhgrh6': {
      'fr': 'Entrez un téléphone valide : +33nnnnnnn',
      'en': '',
    },
    'unjr4mus': {
      'fr': 'Mini 12 caractères',
      'en': '',
    },
    'gmrlnaxn': {
      'fr': 'Limité à 12 caractères',
      'en': '',
    },
    'h8w6ys27': {
      'fr': 'Sous la forme : +33999999999',
      'en': '',
    },
    '5v5bg1gm': {
      'fr': 'Entrez un téléphone valide : +33nnnnnnn',
      'en': '',
    },
    '7bxbpm2d': {
      'fr': 'Se deconnecter',
      'en': '',
    },
    'j1lsyssu': {
      'fr': 'vide env var',
      'en': '',
    },
    '9jdf9js2': {
      'fr':
          'Si vous n\'avez plus accès au numéro de téléphone de votre compte client, vous pouvez le récupérer en cliquant ici',
      'en': '',
    },
    'xjim11r4': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Accueil
  {
    'nsfy0805': {
      'fr': 'DoGether',
      'en': '',
    },
    '0no91nk3': {
      'fr': 'Mode jour/nuit',
      'en': '',
    },
    'gn9iez8n': {
      'fr': 'Se deconnecter',
      'en': '',
    },
    '69f0u26l': {
      'fr': 'Home',
      'en': '',
    },
  },
  // VerifySMS
  {
    'aei8jwtb': {
      'fr': 'Vérification du code SMS',
      'en': '',
    },
    'i1kqxsdi': {
      'fr': 'Merci de saisir le code reçu par SMS.',
      'en': '',
    },
    'r42vc17i': {
      'fr': 'Code SMS',
      'en': '',
    },
    '5bz76abd': {
      'fr': 'Valider',
      'en': '',
    },
    'fj2z2sl6': {
      'fr': 'Dogether',
      'en': '',
    },
    '9etdybbr': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Recues
  {
    'p19e4we1': {
      'fr': 'Invitations reçues',
      'en': '',
    },
    'h150yofh': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Emises
  {
    'lmwyq2ch': {
      'fr': 'Invitations émises',
      'en': '',
    },
    'lbsp2bap': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Contacts
  {
    '06u64kip': {
      'fr': 'Gérer ses contacts',
      'en': '',
    },
    'l7e0ajb4': {
      'fr': 'Créer un contact',
      'en': '',
    },
    'hfscqs7p': {
      'fr': 'Depuis vos contact',
      'en': '',
    },
    'bbh6ee87': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Creer
  {
    '9vq0q4eu': {
      'fr': 'Créer une invitation',
      'en': '',
    },
    'x5knjv1g': {
      'fr': 'Home',
      'en': '',
    },
  },
  // Profil
  {
    'o63lqcpq': {
      'fr': 'Gérer mon profil',
      'en': '',
    },
    'w3w4lyem': {
      'fr': 'Modification du profil',
      'en': '',
    },
    'vakdq7mu': {
      'fr': 'Prénom',
      'en': '',
    },
    'fh77oflu': {
      'fr': 'Saisissez votre prénom',
      'en': '',
    },
    'jk4k0282': {
      'fr': 'Nom ou pseudo',
      'en': '',
    },
    '4z98jwzt': {
      'fr': 'Saisissez votre nom ou votre pseudo',
      'en': '',
    },
    '9qreu8lt': {
      'fr': 'Téléphone',
      'en': '',
    },
    'hg0r8n90': {
      'fr': 'Saisissez un numéro type; +33611459151',
      'en': '',
    },
    'a5uv8xjr': {
      'fr': 'Field is required',
      'en': '',
    },
    'qhy68080': {
      'fr': 'Ce sont des initiales, pas un prénom!',
      'en': '',
    },
    '1q7bd4dy': {
      'fr': 'C\'est déja un beau prénom !!!',
      'en': '',
    },
    'fotqv868': {
      'fr': 'Please choose an option from the dropdown',
      'en': '',
    },
    'su9zn1zc': {
      'fr': 'Field is required',
      'en': '',
    },
    '1u87rn66': {
      'fr': 'C\'est un nom Indien ?',
      'en': '',
    },
    'hec1jq7z': {
      'fr': 'Please choose an option from the dropdown',
      'en': '',
    },
    'zr8smg2m': {
      'fr': 'Field is required',
      'en': '',
    },
    'zj533qbs': {
      'fr': 'Un numéro c\'est 10 chiffres après +indicatif',
      'en': '',
    },
    'v77ikzlz': {
      'fr': 'Il faut enlever le 0 après le +33',
      'en': '',
    },
    'o3rfv104': {
      'fr': 'Please choose an option from the dropdown',
      'en': '',
    },
    'beo3l20y': {
      'fr': 'Annuler',
      'en': '',
    },
    'o9771zno': {
      'fr': 'Valider',
      'en': '',
    },
    'm9keamty': {
      'fr':
          'Si vous changez de numéro de téléphone, il vous faudra ce code pour récupérer votre compte.Sauvegardez le !',
      'en': '',
    },
    'ltdm96bg': {
      'fr':
          'Vous pouvez vous deconnecter de l\'application. Lorsque vous vous reconnecterez une vérification SMS sera à nouveau réalisée. Vous ne perdrez pas votre historique.',
      'en': '',
    },
    'tqidjcdf': {
      'fr': 'Deconnecter',
      'en': '',
    },
    'aj4mxkpr': {
      'fr': 'Home',
      'en': '',
    },
  },
  // RecupCompte
  {
    'y37u8b03': {
      'fr': 'Page Title',
      'en': '',
    },
    'pn1sng0f': {
      'fr': 'DoGether',
      'en': '',
    },
    'oqan22jn': {
      'fr': 'Récupération du compte',
      'en': '',
    },
    'mrk0550e': {
      'fr':
          'Si vous avez sauvegardé le numéro d\'UID correspondant à votre compte vous pourrez récupérer ce compte et le lier à votre nouveau numéro.',
      'en': '',
    },
    'opgddf8o': {
      'fr': 'Majuscules',
      'en': '',
    },
    'lbz39r2i': {
      'fr': 'Partie gauche du code',
      'en': '',
    },
    '9dygtzdq': {
      'fr': 'Chiffres',
      'en': '',
    },
    'r8xm3dyo': {
      'fr': 'Partie droite du code',
      'en': '',
    },
    'lyx4bsz7': {
      'fr': 'Téléphone',
      'en': '',
    },
    'jesyy77q': {
      'fr': 'Saisissez un numéro type; +33611459151',
      'en': '',
    },
    'syqe1liu': {
      'fr': 'Connexion',
      'en': '',
    },
    '7e9q8ar5': {
      'fr': 'Se deconnecter',
      'en': '',
    },
    'j77ws45z': {
      'fr': 'vide env var',
      'en': '',
    },
    '9qph21s1': {
      'fr': 'Home',
      'en': '',
    },
  },
  // bottomBar
  {
    '27jeh3t1': {
      'fr': 'Recues',
      'en': '',
    },
    'mym9dhcg': {
      'fr': 'Emises',
      'en': '',
    },
    'mrdfwvpk': {
      'fr': 'Créer',
      'en': '',
    },
    'ur2rbvx6': {
      'fr': 'Contacts',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'ps6liywx': {
      'fr':
          'L\'utilisation de l\'application nécessite l\'accès à vos contacts pour fonctionner correctement.',
      'en': '',
    },
    'igujenzg': {
      'fr':
          'L\'utilisation de l\'application nécessite l\'utilisation des notifications pour fonctionner correctement.',
      'en': '',
    },
    'y5nw71di': {
      'fr': '',
      'en': '',
    },
    'vj51lhb4': {
      'fr': '',
      'en': '',
    },
    '1490mp5v': {
      'fr': '',
      'en': '',
    },
    '6yejgbyl': {
      'fr': '',
      'en': '',
    },
    '4wttltku': {
      'fr': '',
      'en': '',
    },
    'fbglqyim': {
      'fr': '',
      'en': '',
    },
    'rasg1x0b': {
      'fr': '',
      'en': '',
    },
    'oh9opj0x': {
      'fr': '',
      'en': '',
    },
    '0wtskftj': {
      'fr': '',
      'en': '',
    },
    'red7dzet': {
      'fr': '',
      'en': '',
    },
    'r5zkoow2': {
      'fr': '',
      'en': '',
    },
    '2f4x0him': {
      'fr': '',
      'en': '',
    },
    '0d100vk2': {
      'fr': '',
      'en': '',
    },
    '6obd2igh': {
      'fr': '',
      'en': '',
    },
    '86u7lwzm': {
      'fr': '',
      'en': '',
    },
    'd7sxceut': {
      'fr': '',
      'en': '',
    },
    'aufoogxu': {
      'fr': '',
      'en': '',
    },
    'p1704ipf': {
      'fr': '',
      'en': '',
    },
    '1a10b7lk': {
      'fr': '',
      'en': '',
    },
    '2dqn8gp7': {
      'fr': '',
      'en': '',
    },
    'oocdgu63': {
      'fr': '',
      'en': '',
    },
    'cxnn7md6': {
      'fr': '',
      'en': '',
    },
    'wtzbjn48': {
      'fr': '',
      'en': '',
    },
    'ajqzdm21': {
      'fr': '',
      'en': '',
    },
    'ftlxhzpx': {
      'fr': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
