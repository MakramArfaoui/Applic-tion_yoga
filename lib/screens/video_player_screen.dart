import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  Future<void> _launchVideo() async {
    final Uri url = Uri.parse(videoUrl);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Lance immédiatement la vidéo et ferme l'écran
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchVideo();
      Navigator.of(context).pop();
    });

    // Affiche un indicateur de chargement pendant la transition
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
