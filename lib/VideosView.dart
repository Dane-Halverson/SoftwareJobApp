import 'package:final_project/VideosList.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'models/VideosModel.dart';
//import 'package:units/presenters/CalculatorPresenter.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideosStatefulWidget(key: super.key),
    );
  }
}

class VideosStatefulWidget extends StatefulWidget {
  const VideosStatefulWidget({super.key});

  @override
  State<VideosStatefulWidget> createState() => _VideosStatefulWidgetState();
}

class _VideosStatefulWidgetState extends State<VideosStatefulWidget> {
  final VideosModel model = VideosModel();
  int? _value = 1;
  final List<Widget> _pages = <Widget>[];
  late final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: model.videos.first.videos.first.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));

  @override
  Widget build(BuildContext context) {
    for (VideosList p in model.videos) {
      _pages.add(
        ListView(
          children: getVideos(p),
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Videos",
          ),
        ),
        body: Column(
          children: [
            YoutubePlayer(
              controller: _controller,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: getChips(),

            ),),

            Expanded(child: _pages.elementAt(_value! - 1)),
          ],
        ));
  }

  List<ChoiceChip> getChips() {
    List<ChoiceChip> chips = [];
    int i = 1;
    for (VideosList list in model.videos) {
      chips.add(
        ChoiceChip(
          label: Text(list.type),
          selectedColor: Colors.deepPurpleAccent.shade100,
          selected: _value == i,
          onSelected: (bool selected) {
            setState(() {
              _value = selected ? i : null;
            });
          },
        ),
      );
      i = i + 1;
    }
    return chips;
  }

  List<Widget> getVideos(VideosList videosList) {
    List<Widget> videos = [];

    for (var video in videosList.videos) {
      videos.add(GestureDetector(
        onTap: () {
          _controller.load(video.id);
        },
        child: Card(
            shape: RoundedRectangleBorder(
              side: const BorderSide(),
              borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.play_arrow_outlined,
                  size: 40,
                ),
                Expanded(
                  child: Text(
                    video.title,
                    style: const TextStyle(
                      //color: Colors.white,
                      fontFamily: "WorkSans",
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            )),
      ));
    }

    return videos;
  }
}
