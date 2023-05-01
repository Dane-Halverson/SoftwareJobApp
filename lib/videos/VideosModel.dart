
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Video.dart';
import 'VideosList.dart';

class VideosModel {
  
  static void addFavorite(String id, String title) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users')
        .doc(uid).collection('favorites').doc(id).set({'title': title});
  }

  static void rmFavorite(String id) async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance.collection('users')
        .doc(uid).collection('favorites').doc(id).delete();
  }
  
  
  static Future<List<VideosList>> getVideosList() async {
    List<VideosList> videos = [];
    VideosList favoriteVideos = VideosList(type: 'Favorites', videos: <Video>[]);
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    CollectionReference<Video> favoritesListCollection = FirebaseFirestore.instance.collection('users').doc(uid)
      .collection('favorites').withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
          final data = snapshot.data()!;
          final id = snapshot.id;
          return Video(
            id: id,
            title: data['title'],
            isFavorite: true
          );
        },
        toFirestore: (Video video, _) {
            final Map<String, dynamic> map = {
              'title': video.title,
            };
            return map;
        }
    );
    final favoritesSnapshot = await favoritesListCollection.get();

    for (var document in favoritesSnapshot.docs) {
      final video = document.data();
      favoriteVideos.videos.add(video);
    }
    videos.add(favoriteVideos);

    final videosListCollection = FirebaseFirestore.instance.collection('videos')
      .withConverter(
        fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
          final data = snapshot.data()!;
          final id = snapshot.id;
          return Video(
              id: id,
              title: data['title'],
              isFavorite: true
          );
        },
        toFirestore: (Video video, _) {
          final Map<String, dynamic> map = {
            'title': video.title,
          };
          return map;
        }
    );
    // Get documents from Firestore collection
    final snapshot = await videosListCollection.get();
    // Loop through documents and populate videosList
    int i = 1;
    for (var document in snapshot.docs) {
      String type = document.id;
      List<Video> videosList = [];
      // Get videos from subcollection
      final categoryVideosCollection = videosListCollection.doc(document.id).collection('videos')
        .withConverter(
          fromFirestore: (DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
            final data = snapshot.data()!;
            final id = snapshot.id;
            return Video(
                id: id,
                title: data['title'],
                isFavorite: false
            );
          },
          toFirestore: (Video video, _) {
            final Map<String, dynamic> map = {
              'title': video.title,
            };
            return map;
          }
      );

      final categorySnapshot = await categoryVideosCollection.get();
        for (var videoDoc in categorySnapshot.docs) {
          bool isFav = false;
          for (var v in videos[0].videos) {
            if (v.id == videoDoc.id) {
              isFav = true;
            }
          }
          videosList.add(Video(
              id: videoDoc.id,
              title: videoDoc.data().title,
              isFavorite: isFav
          ));
        }
        videos.add(VideosList(type: type, videos: videosList));
    }

    return videos;
  }
}