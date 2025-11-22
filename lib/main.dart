/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multimodule/allmodules.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme, // This will apply Manrope globally to all text styles
        ),

      ),

      // home:HomePage(),
      home:Allmodules(),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication.dart';
import 'Wrapper.dart';
import 'allmodules.dart';
import 'willdell/templates/template1.dart';

void main() {
  runApp(MyApp());
}



// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             textTheme: Theme.of(context).textTheme.apply(
//               fontSizeFactor: .75,
//               fontSizeDelta: 1.0,
//             ),
//           ),
//           child: child!,
//         );
//       },
//       home: Wrapper(), // Replace this with your home screen widget
//       // other MaterialApp properties...
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // final _navigatorKey = GlobalKey<NavigatorState>();
  // NavigatorState get _navigator => _navigatorKey.currentState!;
  final sessionStateStream = StreamController<SessionState>();

  clearlogs()async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.get('Userdata');
    prefs.clear();
  }


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final sessionConfig = SessionConfig(
      invalidateSessionForAppLostFocus: const Duration(minutes: 10),
      invalidateSessionForUserInactivity: const Duration(minutes: 10),
    );
    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // stop listening, as user will already be in auth page
      // sessionStateStream.add(SessionState.stopListening);
      sessionStateStream.add(SessionState.startListening);

      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        print('logging you out');
        clearlogs();
        // popup(context);
        // Builder(builder: (BuildContext context) { return popup(context); },);
        print('logged out');
        // handle user  inactive timeout

        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Login(
            sessionStateStream: sessionStateStream,
            // loggedOutReason: "Logged out because of user inactivity"
          ),
        ));


      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        // handle user  app lost focus timeout
        print('locking');
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => Login(sessionStateStream: sessionStateStream,
            // loggedOutReason: "Logged out because app lost focus"
          ),
        ));
      }
    });


    return SessionTimeoutManager(
        userActivityDebounceDuration: const Duration(minutes: 10),
        sessionConfig: sessionConfig,
        sessionStateStream: sessionStateStream.stream,
        child: GetMaterialApp(
          builder: (context, child){
            return Theme(
                data: Theme.of(context).copyWith(
                  textTheme: Theme.of(context).textTheme.apply(
                      fontSizeFactor: .75,
              fontSizeDelta: 1.0,
                      // fontFamily: GoogleFonts.openSans().fontFamily!
                      // fontFamily: GoogleFonts.raleway().fontFamily!
                      // poppinsTextTheme()
                      fontFamily: GoogleFonts.poppins().fontFamily
                  ),
                ),
                child: child!
            );
          },
          themeMode: ThemeMode.system,
          // theme: Themes().lightTheme,
          // darkTheme: Themes().darkTheme,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          // home: widtest(),
          // home:Allmodules(),
          home: Wrapper(sessionStateStream: sessionStateStream,),
          // home: HtmlEditorExample(),
        )
    );

  }
}
