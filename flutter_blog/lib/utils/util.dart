import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  if (url == null) throw 'No url found!';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}