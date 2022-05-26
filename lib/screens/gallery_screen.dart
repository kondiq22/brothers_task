import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/photos_api_request.dart';
import 'widgets/error_dialog.dart';
import 'widgets/image_dialog.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => ImageDialog(
                              imageUrl: snapshot.data![index].url,
                              title: snapshot.data![index].title,
                            ));
                  },
                  child: CachedNetworkImage(
                      imageUrl: snapshot.data![index].thumbnailUrl,
                      placeholder: (context, url) => const Center(
                            child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator()),
                          ),
                      errorWidget: (context, url, error) {
                        return const Icon(Icons.error);
                      }));
            },
          );
        } else if (snapshot.hasError) {
          return errorDialog(
              context, 'Failed to Fetch Data', snapshot.error.toString());
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
