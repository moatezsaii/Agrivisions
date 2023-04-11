import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'fr'];

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
    String? enText = '',
    String? frText = '',
  }) =>
      [enText, frText][languageIndex] ?? '';

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
  // Connect
  {
    'tgs1m2zn': {
      'en': 'AgriVision',
      'fr': 'AgriVision',
    },
    '69w84ipl': {
      'en': 'Let\'s sign in',
      'fr': 'S\'inscrire',
    },
    'e7zsai33': {
      'en':
          'We’re waiting for you to sign in again and start your journey with us ',
      'fr':
          'Nous attendons que vous vous reconnectiez et que vous commenciez votre voyage avec nous. ',
    },
    'kbxrbsla': {
      'en': 'Email Address',
      'fr': 'Adresse électronique',
    },
    'v7ijvwc6': {
      'en': 'Enter your email here...',
      'fr': 'Saisissez votre adresse électronique ici...',
    },
    '5zsu6bh9': {
      'en': 'Password',
      'fr': 'Mot de passe',
    },
    '90fig8m3': {
      'en': 'Enter your password here...',
      'fr': 'Entrez votre mot de passe ici...',
    },
    'm23xgp5w': {
      'en': 'Forgot Password?',
      'fr': 'Mot de passe oublié ?',
    },
    'tkx9icj7': {
      'en': 'Login',
      'fr': 'Connexion',
    },
    'wjztdmt7': {
      'en': 'Or continue with',
      'fr': 'Vous n\'avez pas de compte ?',
    },
    'cedhnyzf': {
      'en': '',
      'fr': 'Se connecter avec Facebook',
    },
    'o0peagcu': {
      'en': '',
      'fr': 'Se connecter avec Google',
    },
    '07ck6x1t': {
      'en': 'Don\'t have an account?',
      'fr': 'Vous n\'avez pas de compte ?',
    },
    'ih5a1xli': {
      'en': 'Create Account',
      'fr': 'Créer un compte',
    },
    'xgt3bqta': {
      'en': 'Home',
      'fr': 'home',
    },
  },
  // SignUp
  {
    'ml2uprh0': {
      'en': 'AgriVision',
      'fr': 'AgriVision',
    },
    '5nl96egc': {
      'en': 'Get Started',
      'fr': 'Commencer',
    },
    'd2pgewhn': {
      'en': 'Use the form below to get started.',
      'fr': 'Utilisez le formulaire ci-dessous pour commencer.',
    },
    'fbj50vvl': {
      'en': 'Full Name',
      'fr': 'Adresse électronique',
    },
    '9193jy19': {
      'en': 'Your Full Name here...',
      'fr': 'Saisissez votre adresse électronique ici...',
    },
    'yqg2il9u': {
      'en': 'Email Address',
      'fr': 'Adresse électronique',
    },
    'xqq96098': {
      'en': 'Enter your email here...',
      'fr': 'Saisissez votre adresse électronique ici...',
    },
    '8l6xtgh5': {
      'en': 'Password',
      'fr': 'Mot de passe',
    },
    'w28p3ofx': {
      'en': 'Enter your password here...',
      'fr': 'Entrez votre mot de passe ici...',
    },
    '8k50tyys': {
      'en': 'Confirm Password',
      'fr': 'Confirm Password',
    },
    'q2y1sd47': {
      'en': 'Confirm your password here...',
      'fr': 'Confirmez votre mot de passe ici...',
    },
    'o6d9qlwl': {
      'en': 'Create Account',
      'fr': 'Créer un compte',
    },
    'qmudedmu': {
      'en': 'Use a social platform to continue',
      'fr': 'Utiliser une plateforme sociale pour continuer',
    },
    'xrr4vaos': {
      'en': 'Sign Up with Facebook',
      'fr': 'Inscrivez-vous avec Facebook',
    },
    'y3vjajyy': {
      'en': 'Sign up with Google',
      'fr': 'S\'inscrire avec Google',
    },
    'si6ycd7t': {
      'en': 'Already have an account?',
      'fr': 'Vous avez deja un compte?',
    },
    'diisfe2s': {
      'en': 'Log In',
      'fr': 'Se connecter',
    },
    'jbj85ujd': {
      'en': 'Home',
      'fr': 'Acceuil',
    },
  },
  // Profile
  {
    '87apke8c': {
      'en': 'General',
      'fr': 'Général',
    },
    'xqcykr3e': {
      'en': 'General info',
      'fr': 'Informations générales',
    },
    'viykj9by': {
      'en': 'Password',
      'fr': 'mot de passe',
    },
    'lh74r8zg': {
      'en': 'Language',
      'fr': 'langue',
    },
    'faf8bv2w': {
      'en': 'Your plan',
      'fr': 'votre plan',
    },
    '71pxfpkg': {
      'en': 'Notification',
      'fr': 'notification',
    },
    '2mfg88gi': {
      'en': 'Notification',
      'fr': 'notification',
    },
    'zglqwl10': {
      'en': 'Terms of Service',
      'fr': 'Conditions d\'utilisation',
    },
    '0zrm506u': {
      'en': 'Contact us',
      'fr': 'Inviter des amis',
    },
    'neqmrdw4': {
      'en': 'Log out',
      'fr': 'Inviter des amis',
    },
    'c909i6ce': {
      'en': 'Profile',
      'fr': 'Profile',
    },
  },
  // Trees
  {
    '0d2brv9g': {
      'en': 'History',
      'fr': 'Histoire',
    },
    '20wltuv3': {
      'en': 'My Trees',
      'fr': 'Mes arbres',
    },
    '5kczo6ay': {
      'en': '28/03/2023 12:16',
      'fr': '28/03/2023 12:16',
    },
    't7t6h83q': {
      'en': 'palm tree',
      'fr': 'palmier',
    },
    '6pdtyfn7': {
      'en': 'tree info here',
      'fr': 'infos sur l\'arbre ici',
    },
    'z5f2ivf5': {
      'en': 'Trees',
      'fr': 'Des arbres',
    },
  },
  // Camera
  {
    'dn4s2z31': {
      'en': 'Camera',
      'fr': 'Caméra',
    },
  },
  // HomeScreen
  {
    'e6f6xopf': {
      'en': 'Happy to see you again',
      'fr': 'Heureux de vous revoir\nMoatez !',
    },
    'wui98rkw': {
      'en': 'Write something...',
      'fr': 'Écris quelque chose...',
    },
    'mgfrl2r7': {
      'en': 'Posted',
      'fr': 'Posté',
    },
    'gaiwcphl': {
      'en': 'Home',
      'fr': 'Acceuil',
    },
  },
  // posting
  {
    '086phwtf': {
      'en': 'Create Post',
      'fr': 'Créer une publication',
    },
    'ehuotu7p': {
      'en': 'Upload Photo',
      'fr': 'Envoyer la photo',
    },
    'kzoe62fa': {
      'en': 'Enter post details here...',
      'fr': 'Entrez les détails du poste ici...',
    },
    'vr1gjoo0': {
      'en': 'Field is required',
      'fr': 'Champ requis',
    },
    '608lq8id': {
      'en': 'Please choose an option from the dropdown',
      'fr': 'Veuillez choisir une option dans la liste déroulante',
    },
    'rsrsdnf7': {
      'en': 'Create Post',
      'fr': 'Créer une publication',
    },
  },
  // passwordedit
  {
    'xvzne17x': {
      'en': 'Change Password',
      'fr': 'Changer le mot de passe',
    },
    '2omq76ol': {
      'en': 'YOUR E_MAIL',
      'fr': 'VOTRE E_MAIL',
    },
    'r6rnksl3': {
      'en': '',
      'fr': '',
    },
    'qfa74frv': {
      'en':
          'Want to change your password?\nEnter your E-mail associated with your account and click on the \"Change Password\" link.\nWe\'ll send you an email with instructions on how to reset your password. If you don\'t receive the email within a few minutes, please check your spam folder or try again. If you continue to experience issues, please contact our support team for further assistance',
      'fr':
          'Vous voulez changer votre mot de passe ?\nSaisissez votre E-mail associé à votre compte et cliquez sur le lien « Changer de mot de passe ».\nNous vous enverrons un e-mail avec des instructions sur la façon de réinitialiser votre mot de passe. Si vous ne recevez pas l\'e-mail après quelques minutes, veuillez vérifier votre dossier spam ou réessayer. Si vous continuez à rencontrer des problèmes, veuillez contacter notre équipe d\'assistance pour obtenir de l\'aide.',
    },
    'b5muoth8': {
      'en': 'Change Password',
      'fr': 'Changer le mot de passe',
    },
    'rryr9a5t': {
      'en': 'Password Settings',
      'fr': 'Paramètres de mot de passe',
    },
    'yaqjx2f8': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // editprofile
  {
    'x204am8c': {
      'en': 'Change Photo',
      'fr': 'Changer la photo',
    },
    '73bmplgs': {
      'en': 'Your Name',
      'fr': 'votre nom',
    },
    'yxx6632l': {
      'en': 'Email Address',
      'fr': 'Adresse e-mail',
    },
    'ybuwrgg1': {
      'en': 'Your phone number',
      'fr': 'Votre numéro de téléphone',
    },
    'yrci6jw1': {
      'en': 'Save Changes',
      'fr': 'Sauvegarder les modifications',
    },
    '9k5ljeim': {
      'en': 'Edit Profile',
      'fr': 'Editer le profil',
    },
  },
  // contactus
  {
    'cyanbbl4': {
      'en': 'contactus@agrivision.com',
      'fr': 'contactez-nous@agrivision.com',
    },
    '5x4xcmcb': {
      'en': '+216 58 585 585',
      'fr': '+216 58 585 585',
    },
    'qq0flnpz': {
      'en': 'Contact Us',
      'fr': 'Contactez-nous',
    },
    'i6rabbqy': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // TERMSofservice
  {
    'r0xieaaw': {
      'en':
          'By using our app or services, you agree to be bound by these Terms of Service (\"Terms\"). These Terms govern your access to and use of our app and services (collectively, \"Services\"). Please read these Terms carefully before using our Services. If you do not agree to these Terms, you may not use our Services. We reserve the right to modify these Terms at any time, and your continued use of our Services after any such modifications constitutes your acceptance of the modified Terms. We may also update or modify our Services from time to time, and these changes may affect your use of the Services. Your continued use of our Services after any such updates or modifications also constitutes your acceptance of the updated or modified Services.',
      'fr':
          'En utilisant notre application ou nos services, vous acceptez d\'être lié par les présentes conditions d\'utilisation (\"Conditions\"). Ces conditions régissent votre accès et votre utilisation de notre application et de nos services (collectivement, les « services »). Veuillez lire attentivement ces Conditions avant d\'utiliser nos Services. Si vous n\'acceptez pas ces Conditions, vous ne pouvez pas utiliser nos Services. Nous nous réservons le droit de modifier ces Conditions à tout moment, et votre utilisation continue de nos Services après de telles modifications constitue votre acceptation des Conditions modifiées. Nous pouvons également mettre à jour ou modifier nos Services de temps à autre, et ces changements peuvent affecter votre utilisation des Services. Votre utilisation continue de nos Services après de telles mises à jour ou modifications constitue également votre acceptation des Services mis à jour ou modifiés.',
    },
    'w52wf9n4': {
      'en': 'Terms of Service',
      'fr': 'Conditions d\'utilisation',
    },
    'wlrc7sni': {
      'en': 'Home',
      'fr': 'Maison',
    },
  },
  // Miscellaneous
  {
    'uf202zc9': {
      'en': '',
      'fr': '',
    },
    '1vs37jcn': {
      'en': '',
      'fr': '',
    },
    'i9jxw7mx': {
      'en': '',
      'fr': '',
    },
    'nfyvwm0c': {
      'en': '',
      'fr': '',
    },
    'cx3n1yh8': {
      'en': '',
      'fr': '',
    },
    'p5yicbwu': {
      'en': '',
      'fr': '',
    },
    'ly3kbglx': {
      'en': '',
      'fr': '',
    },
    '9s7neokx': {
      'en': '',
      'fr': '',
    },
    'bh101lm7': {
      'en': '',
      'fr': '',
    },
    'vg9uyp07': {
      'en': 'Invalid Format',
      'fr': 'Format invalide',
    },
    'aj8zzkbk': {
      'en': 'Uploading',
      'fr': 'Téléchargement',
    },
    'a6ndew73': {
      'en': 'Success!',
      'fr': 'Succès!',
    },
    'dlawa1iv': {
      'en': 'Failed',
      'fr': 'Échoué',
    },
    '3obcdlvn': {
      'en': '',
      'fr': '',
    },
    '6ezclxoo': {
      'en': '',
      'fr': '',
    },
    'ri4igmy5': {
      'en': '',
      'fr': '',
    },
    '1h0l23w5': {
      'en': '',
      'fr': '',
    },
    'f5cac7ok': {
      'en': '',
      'fr': '',
    },
    'xbsm2z2q': {
      'en': '',
      'fr': '',
    },
    '4cdzqvra': {
      'en': '',
      'fr': '',
    },
    'ph0q01q9': {
      'en': '',
      'fr': '',
    },
    'mwwmh0f0': {
      'en': '',
      'fr': '',
    },
    '1d9geisa': {
      'en': '',
      'fr': '',
    },
  },
].reduce((a, b) => a..addAll(b));
