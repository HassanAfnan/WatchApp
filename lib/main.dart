import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_twitter_clone/helper/theme.dart';
import 'package:flutter_twitter_clone/page/feed/composeTweet/state/composeTweetState.dart';
import 'package:flutter_twitter_clone/state/searchState.dart';
import 'package:flutter_twitter_clone/watch/ThemeModes/Theme.dart';
import 'package:flutter_twitter_clone/watch/signin_screen.dart';
import 'package:flutter_twitter_clone/watch/spash_screen.dart';
import 'helper/routes.dart';
import 'state/appState.dart';
import 'package:provider/provider.dart';
import 'state/authState.dart';
import 'state/chats/chatState.dart';
import 'state/feedState.dart';

import 'state/adminState.dart';
import 'package:google_fonts/google_fonts.dart';

import 'state/notificationState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(create: (_) => AppState()),
        ChangeNotifierProvider<AuthState>(create: (_) => AuthState()),
        ChangeNotifierProvider<FeedState>(create: (_) => FeedState()),
        ChangeNotifierProvider<ChatState>(create: (_) => ChatState()),
        ChangeNotifierProvider<SearchState>(create: (_) => SearchState()),
        ChangeNotifierProvider<AdminState>(create: (_) => AdminState()),
        ChangeNotifierProvider<ComposeTweetState>(create: (_) => ComposeTweetState()),
        ChangeNotifierProvider<NotificationState>(create: (_) => NotificationState()),
        ChangeNotifierProvider(create: (_) => ThemeNotifier())
      ],

      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {
          return MaterialApp(
            title: 'Elite Edge Ware',
            debugShowCheckedModeBanner: false,
            theme: notifier.darkTheme ? dark : light,
            routes: Routes.route(),
            onGenerateRoute: (settings) => Routes.onGenerateRoute(settings),
            onUnknownRoute: (settings) => Routes.onUnknownRoute(settings),
            home: WatchSplashScreen(),
          );
        } ,
      ),
    );
  }
}
