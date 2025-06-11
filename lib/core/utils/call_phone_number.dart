import 'package:url_launcher/url_launcher.dart';

Future<void> callNumber(String phoneNumber) async {
  final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(telUri)) {
    await launchUrl(telUri);
  } else {
    throw 'Could not launch $telUri';
  }
}
