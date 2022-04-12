import 'package:awesome_notifications/awesome_notifications.dart';
int createUniqueId(){
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}
Future<void>createPostureNotification() async {
  await AwesomeNotifications().createNotification(content:
  NotificationContent(id: createUniqueId(),
      channelKey: 'channel name',
    title: '${Emojis.smile_angry_face} Bad Posture Alert',
    body: 'Adjust your position',
  ));
}