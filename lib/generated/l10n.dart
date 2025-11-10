// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `By continuing to use this site, you accept our use of a cookie to keep you signed in and secure.`
  String get byContinuingToUseThisSiteYouAcceptOurUse {
    return Intl.message(
      'By continuing to use this site, you accept our use of a cookie to keep you signed in and secure.',
      name: 'byContinuingToUseThisSiteYouAcceptOurUse',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get appSettings {
    return Intl.message(
      'App Settings',
      name: 'appSettings',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Other`
  String get other {
    return Intl.message('Other', name: 'other', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `{minutes} min ago`
  String diffinminutesMinAgo(int minutes) {
    return Intl.message(
      '$minutes min ago',
      name: 'diffinminutesMinAgo',
      desc: 'Text shown when time difference is in minutes.',
      args: [minutes],
    );
  }

  /// `{hours} hr ago`
  String diffinhoursHrAgo(int hours) {
    return Intl.message(
      '$hours hr ago',
      name: 'diffinhoursHrAgo',
      desc: 'Text shown when time difference is in hours.',
      args: [hours],
    );
  }

  /// `{days} days ago`
  String diffindaysDaysAgo(int days) {
    return Intl.message(
      '$days days ago',
      name: 'diffindaysDaysAgo',
      desc: 'Text shown when time difference is in days.',
      args: [days],
    );
  }

  /// `{weeks} w ago`
  String diffindays7floorWAgo(int weeks) {
    return Intl.message(
      '$weeks w ago',
      name: 'diffindays7floorWAgo',
      desc: 'Text shown when time difference is in weeks.',
      args: [weeks],
    );
  }

  /// `{months} mo ago`
  String diffindays30floorMoAgo(int months) {
    return Intl.message(
      '$months mo ago',
      name: 'diffindays30floorMoAgo',
      desc: 'Text shown when time difference is in months.',
      args: [months],
    );
  }

  /// `{years} yr ago`
  String diffindays365floorYrAgo(int years) {
    return Intl.message(
      '$years yr ago',
      name: 'diffindays365floorYrAgo',
      desc: 'Text shown when time difference is in years.',
      args: [years],
    );
  }

  /// `Failed to load image`
  String get failedToLoadImage {
    return Intl.message(
      'Failed to load image',
      name: 'failedToLoadImage',
      desc: '',
      args: [],
    );
  }

  /// `NotAvailable`
  String get notavailable {
    return Intl.message(
      'NotAvailable',
      name: 'notavailable',
      desc: '',
      args: [],
    );
  }

  /// `UnknownSource`
  String get unknownsource {
    return Intl.message(
      'UnknownSource',
      name: 'unknownsource',
      desc: '',
      args: [],
    );
  }

  /// `source info not available`
  String get sourceInfoNotAvailable {
    return Intl.message(
      'source info not available',
      name: 'sourceInfoNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Real facts. No bias. Global updates\n you can trust.`
  String get realFactsNoBiasGlobalUpdatesnYouCanTrust {
    return Intl.message(
      'Real facts. No bias. Global updates\n you can trust.',
      name: 'realFactsNoBiasGlobalUpdatesnYouCanTrust',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Google`
  String get continueWithGoogle {
    return Intl.message(
      'Continue with Google',
      name: 'continueWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `No bookmarks yet.`
  String get noBookmarksYet {
    return Intl.message(
      'No bookmarks yet.',
      name: 'noBookmarksYet',
      desc: '',
      args: [],
    );
  }

  /// `Click to refresh.`
  String get clickToRefresh {
    return Intl.message(
      'Click to refresh.',
      name: 'clickToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `No news available`
  String get noNewsAvailable {
    return Intl.message(
      'No news available',
      name: 'noNewsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Search News`
  String get searchNews {
    return Intl.message('Search News', name: 'searchNews', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Bookmark`
  String get bookmark {
    return Intl.message('Bookmark', name: 'bookmark', desc: '', args: []);
  }

  /// `View Full Article`
  String get viewFullArticle {
    return Intl.message(
      'View Full Article',
      name: 'viewFullArticle',
      desc: '',
      args: [],
    );
  }

  /// `No news found.`
  String get noNewsFound {
    return Intl.message(
      'No news found.',
      name: 'noNewsFound',
      desc: '',
      args: [],
    );
  }

  /// `Type something to get results...`
  String get typeSomethingToGetResults {
    return Intl.message(
      'Type something to get results...',
      name: 'typeSomethingToGetResults',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get appLanguage {
    return Intl.message(
      'App Language',
      name: 'appLanguage',
      desc: '',
      args: [],
    );
  }

  /// `App Theme`
  String get appTheme {
    return Intl.message('App Theme', name: 'appTheme', desc: '', args: []);
  }

  /// `Rate Us`
  String get rateUs {
    return Intl.message('Rate Us', name: 'rateUs', desc: '', args: []);
  }

  /// `Share App`
  String get shareApp {
    return Intl.message('Share App', name: 'shareApp', desc: '', args: []);
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `System Default`
  String get systemDefault {
    return Intl.message(
      'System Default',
      name: 'systemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get areYouSureYouWantToLogout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'areYouSureYouWantToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Read Privacy Policy`
  String get readPrivacyPolicy {
    return Intl.message(
      'Read Privacy Policy',
      name: 'readPrivacyPolicy',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'ml'),
      Locale.fromSubtags(languageCode: 'mr'),
      Locale.fromSubtags(languageCode: 'ta'),
      Locale.fromSubtags(languageCode: 'te'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
