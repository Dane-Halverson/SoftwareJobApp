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
  int? _value = 1;
  final List<Widget> _pages = <Widget>[];
  final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: VideosModel.techniqueVideoIds[0].item2,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      )
  );


  @override
  Widget build(BuildContext context) {
    _pages.add(ListView(
      children: getVideos(VideosModel.techniqueVideoIds),
    ),
    );
    _pages.add(ListView(
      children: getVideos(VideosModel.asmrVideoIds),
    ),
    );
    _pages.add(ListView(
      children: getVideos(VideosModel.musicVideoIds),
    ),
    );

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
            Row(
              children: [
                Wrap(
                  spacing: 5.0,
                  children: [
                    ChoiceChip(
                      label: const Text('Sleep Techniques'),
                      selectedColor: Colors.deepPurpleAccent.shade100,

                      selected: _value == 1,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 1 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('ASMR'),
                      selectedColor: Colors.deepPurpleAccent.shade100,

                      selected: _value == 2,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 2 : null;
                        });
                      },
                    ),
                    ChoiceChip(
                      label: const Text('Sleep Music'),
                      selectedColor: Colors.deepPurpleAccent.shade100,
                      selected: _value == 3,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = selected ? 3 : null;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            Expanded(child: _pages.elementAt(_value! - 1)),
          ],
        ));
  }

  List<Widget> getVideos(List<Tuple2> ids) {
    List<Widget> videos = [];

    for (var video in ids) {
      videos.add(
          GestureDetector(
            onTap: () {
              _controller.load(video.item2);
            },
            child:
            Card(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                  ),
                  borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
                ),

                child: Row(
                  children: [
                    const Icon(Icons.play_arrow_outlined,
                        size: 40,
                    ),
                    Expanded(
                      child:
                      Text(
                        video.item1,
                        style: const TextStyle(
                          //color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 25,
                        ),
                      ),

                    ),

                  ],
                )

            ),
          ));

    }

    return videos;
  }
}
