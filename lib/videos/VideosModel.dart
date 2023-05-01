
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
    VideosList favoriteVideos = VideosList(type: 'Favorites');

    String? uid = FirebaseAuth.instance.currentUser?.uid;

    CollectionReference favoritesListCollection = FirebaseFirestore.instance
        .collection('users').doc(uid).collection('favorites');

    var favoritesSnapshot = await favoritesListCollection.get();


    for (var document in favoritesSnapshot.docs) {
      String id = document.id;
      String title = await document.get('title');
      favoriteVideos.videos.add(Video(id: id, title: title, isFavorite: true));
    }

    videos.add(favoriteVideos);

    CollectionReference videosListCollection =
    FirebaseFirestore.instance.collection('videos');

    // Get documents from Firestore collection
    QuerySnapshot snapshot = await videosListCollection.get();

    // Loop through documents and populate videosList
    int i = 1;
    for (var document in snapshot.docs) {
      String type = document.id;
      List<Video> videosList = [];

      // Get videos from subcollection
      CollectionReference videosCollection =
      videosListCollection.doc(document.id).collection('videos');

      var videoSnapshot = await videosCollection.get();
        for (var videoDoc in videoSnapshot.docs) {
          bool isFav = false;
          for (var v in videos[0].videos) {
            if (v.id == videoDoc.id) {
              isFav = true;
            }
          }

          videosList.add(Video(
              id: videoDoc.id,
              title: videoDoc.get('title'),
              isFavorite: isFav));
        }

        videos.add(VideosList(type: type, videos: videosList));
    }

    return videos;
  }
}