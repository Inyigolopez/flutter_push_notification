import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';



class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotifications(){

    _firebaseMessaging.requestNotificationPermissions();

    _firebaseMessaging.getToken().then ((token){

      print('======= FCM Token =======');
      print(token);

      //ecEpC83QuFg:APA91bGJz66fjjkGGFSuF-PxxZfz2MQUo3-vLhK4mtLiLNw6xnsByGpDWPGaizIg5U9TjYfLQh5cMin7yzgzoVFc_RJnDhNpAFp3olGow7jomX9Tzx8qmCeHjpPqgYUwwh8KMZ02ge_t

    });

    _firebaseMessaging.configure(

      onMessage: (info) async {
        print(' ======= ON MESSAGES ======');
        print(info);

        String argumento = 'no-data';
        if( Platform.isAndroid ){
          argumento = info['data']['comida'] ?? 'no-data';
        }

        _mensajesStreamController.sink.add(argumento);

      },
      onLaunch: (info) async {
        print(' ======= ON LAUNCH ======');
        print(info);

        String argumento = 'no-data';
        if( Platform.isAndroid ){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        
        _mensajesStreamController.sink.add(argumento);

      },
      onResume: (info) async {
        print(' ======= ON Resume ======');
        print(info);

        String argumento = 'no-data';
        if( Platform.isAndroid ){
          argumento = info['data']['comida'] ?? 'no-data';
        }
        
        _mensajesStreamController.sink.add(argumento);
        // final argumento = info['data']['comida'];
        // print(argumento);

      }

    );

  }


  dispose(){
    _mensajesStreamController.close();
  }


}
