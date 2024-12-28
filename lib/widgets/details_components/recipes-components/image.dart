import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableImage extends StatelessWidget {
  final String imageUrl;
  final String link;

  const ClickableImage({
    Key? key,
    required this.imageUrl,
    required this.link,
  }) : super(key: key);

  void _launchURL() {
    try {
      launchUrl(
          Uri.parse(link));
    } catch (e){}
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _launchURL();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            height: 200,
            width: screenWidth,
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return Image.asset(
                'lib/assets/image_not_found.png',
                height: 200,
                width: screenWidth * 0.95,
                fit: BoxFit.cover,
              );
            },
          ),
          const Icon(
            Icons.play_circle_filled,
            color: Color(0xFF76FDB1),
            size: 50,
          ),
        ],
      ),
    );
  }
}
