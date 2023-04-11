import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';

import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  await FlutterFlowTheme.initialize();

  final appState = FFAppState(); // Initialize FFAppState

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = FlutterFlowTheme.themeMode;

  late Stream<AgriVisionFirebaseUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);
    userStream = agriVisionFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(seconds: 1),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  @override
  void dispose() {
    authUserSub.cancel();

    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
        FlutterFlowTheme.saveThemeMode(mode);
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AgriVision',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('fr'),
      ],
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _themeMode,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}

class NavBarPage extends StatefulWidget {
  NavBarPage({Key? key, this.initialPage, this.page}) : super(key: key);

  final String? initialPage;
  final Widget? page;

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

/// This is the private State class that goes with NavBarPage.
class _NavBarPageState extends State<NavBarPage> {
  String _currentPageName = 'HomeScreen';
  late Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPageName = widget.initialPage ?? _currentPageName;
    _currentPage = widget.page;
  }

  @override
  Widget build(BuildContext context) {
    final tabs = {
      'HomeScreen': HomeScreenWidget(),
      'Trees': TreesWidget(),
      'Camera': CameraWidget(),
      'Profile': ProfileWidget(),
    };
    final currentIndex = tabs.keys.toList().indexOf(_currentPageName);
    return Scaffold(
      body: _currentPage ?? tabs[_currentPageName],
      extendBody: true,
      bottomNavigationBar: Visibility(
        visible: responsiveVisibility(
          context: context,
          tabletLandscape: false,
          desktop: false,
        ),
        child: FloatingNavbar(
          currentIndex: currentIndex,
          onTap: (i) => setState(() {
            _currentPage = null;
            _currentPageName = tabs.keys.toList()[i];
          }),
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFF4FAF5A),
          unselectedItemColor: FlutterFlowTheme.of(context).grayIcon,
          selectedBackgroundColor: FlutterFlowTheme.of(context).primaryBtnText,
          borderRadius: 8.0,
          itemBorderRadius: 8.0,
          margin: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          width: double.infinity,
          elevation: 0.0,
          items: [
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentIndex == 0 ? Icons.home : Icons.home_outlined,
                    color: currentIndex == 0
                        ? Color(0xFF4FAF5A)
                        : FlutterFlowTheme.of(context).grayIcon,
                    size: 24.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'gaiwcphl' /* Home */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 0
                          ? Color(0xFF4FAF5A)
                          : FlutterFlowTheme.of(context).grayIcon,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentIndex == 1
                        ? FontAwesomeIcons.tree
                        : FontAwesomeIcons.tree,
                    color: currentIndex == 1
                        ? Color(0xFF4FAF5A)
                        : FlutterFlowTheme.of(context).grayIcon,
                    size: 24.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'z5f2ivf5' /* Trees */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 1
                          ? Color(0xFF4FAF5A)
                          : FlutterFlowTheme.of(context).grayIcon,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentIndex == 2 ? Icons.photo_camera : Icons.photo_camera,
                    color: currentIndex == 2
                        ? Color(0xFF4FAF5A)
                        : FlutterFlowTheme.of(context).grayIcon,
                    size: 28.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'dn4s2z31' /* Camera */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 2
                          ? Color(0xFF4FAF5A)
                          : FlutterFlowTheme.of(context).grayIcon,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            FloatingNavbarItem(
              customWidget: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    currentIndex == 3
                        ? Icons.person_rounded
                        : Icons.person_outline,
                    color: currentIndex == 3
                        ? Color(0xFF4FAF5A)
                        : FlutterFlowTheme.of(context).grayIcon,
                    size: 24.0,
                  ),
                  Text(
                    FFLocalizations.of(context).getText(
                      'c909i6ce' /* Profile */,
                    ),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: currentIndex == 3
                          ? Color(0xFF4FAF5A)
                          : FlutterFlowTheme.of(context).grayIcon,
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
