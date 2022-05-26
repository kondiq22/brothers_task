import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;
  final String title;
  const ImageDialog({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 50,
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const Center(
                child: SizedBox(
                    width: 30, height: 30, child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => AlertDialog(
                title: const Text('Failed to load Image'),
                content: const Text('Try again later...'),
                actions: [
                  Center(
                      child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok')))
                ],
              ),
            ),
          ],
        ));
  }
}
