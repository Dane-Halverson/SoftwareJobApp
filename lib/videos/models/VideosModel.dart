import 'VideosList.dart';
import 'Video.dart';

class VideosModel {

  List<VideosList> videos = [];

  VideosModel() {
    videos.add(VideosList(type: "Favorites", videos: []));
    videos.add(
      VideosList(type: "interview tips", videos: [Video(id: 'HG68Ymazo18', title: 'Top Interview Tips: Common Questions, Nonverbal Communication & More | Indeed', isFavorite: false)])
    );


  }

}
