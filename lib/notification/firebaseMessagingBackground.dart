import 'package:firebase_messaging/firebase_messaging.dart';
import '../components.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on background message');
  print(message.data.toString());
  
}