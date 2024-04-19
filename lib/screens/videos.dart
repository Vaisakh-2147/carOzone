import 'package:car_o_zone/screens/player.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final String carName;

  const VideoScreen({Key? key, required this.carName}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: const Text(
          'Videos',
          style: TextStyle(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('carDetails')
            .where('carname', isEqualTo: widget.carName)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List videoUrls = snapshot.data!.docs
                .map((doc) => [
                      doc['video 1'],
                      doc['video 2'],
                      doc['video 3'],
                    ])
                .expand((element) => element)
                .toList();
            return ListView.builder(
              itemCount: videoUrls.length,
              itemBuilder: (context, index) {
                final videoUrl = videoUrls[index];
                if (videoUrl != null) {
                  final videoId = YoutubePlayer.convertUrlToId(videoUrl);
                  return InkWell(
                    onTap: () {
                      if (videoId != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlayerScreen(videoId: videoId),
                        ));
                      }
                    },
                    child: videoId != null
                        ? Image.network(
                            YoutubePlayer.getThumbnail(videoId: videoId))
                        : const Placeholder(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
