import 'dart:ffi';

import 'package:final_project/Index.dart';
import 'package:final_project/VideosList.dart';
import 'package:flutter/material.dart';
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
  int? _value = 0;
  final List<Widget> _pages = <Widget>[];
  late final YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: model.videos.first.videos.first.id,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));

  late final List<VideosList> _options = model.videos;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < model.videos.length; ++i) {
      _pages.add(
        ListView(
          children: List<Widget>.generate(model.videos[i].videos.length, (int index) {
            bool selected = false;
            return GestureDetector(

                onTap: () {
                  _controller.load(model.videos[i].videos[index].id);
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(),
                            borderRadius:
                            BorderRadius.circular(20.0), //<-- SEE HERE
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.play_arrow_outlined,
                                size: 40,
                              ),
                              Expanded(
                                child: Text(
                                  model.videos[i].videos[index].title,
                                  style: const TextStyle(
                                    //color: Colors.white,
                                    fontFamily: "WorkSans",
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          model.videos[i].videos[index].isFavorite = !model.videos[i].videos[index].isFavorite;
                        });
                      },
                      icon: !model.videos[i].videos[index].isFavorite ? const Icon(Icons.favorite_border): const Icon(Icons.favorite),
                    )
                  ],
                ));
          }),
        )
      );

    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Videos",
          ),
        ),
        body: Column(children: [
          YoutubePlayer(
            controller: _controller,
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List<Widget>.generate(_options.length, (int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: ChoiceChip(
                      label: Text(_options[index].type),
                      selected: _value == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _value = index;
                        });
                      },
                    ),
                  );
                }),
              )),
          Expanded(child: _pages.elementAt(_value!)),
        ]));
  }

  List<Widget> getVideos(VideosList videosList) {
    List<Widget> videos = [];

    for (var video in videosList.videos) {
      videos.add(GestureDetector(
          onTap: () {
            _controller.load(video.id);
          },
          child: Row(
            children: [
              Expanded(
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
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border),
              )
            ],
          )));
    }

    return videos;
  }
}
