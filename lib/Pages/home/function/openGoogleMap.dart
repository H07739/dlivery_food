import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMap(double latitude, double longitude) async {

  String url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
