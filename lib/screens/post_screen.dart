import 'package:flutter/material.dart';

import '../services/posts_api_request.dart';
import 'package:http/http.dart' as http;

import 'widgets/error_dialog.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPhotos(http.Client()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.redAccent,
                            Colors.orangeAccent,
                          ],
                        ),
                        border: Border.all(
                          color: Colors.orangeAccent,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          const Padding(padding: EdgeInsets.all(5)),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                snapshot.data![index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                snapshot.data![index].body,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Align(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: Text(snapshot.data![index].email,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
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
