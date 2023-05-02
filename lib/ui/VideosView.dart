
import 'package:final_project/videos/VideosList.dart';
import 'package:flutter/material.dart';
import 'package:final_project/videos/VideosModel.dart';
import 'package:flutter_animated_icons/flutter_animated_icons.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:flutter_animated_icons/lottiefiles.dart';



class VideosView extends StatelessWidget {
  const VideosView({super.key});

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

class _VideosStatefulWidgetState extends State<VideosStatefulWidget> with TickerProviderStateMixin{

  final List<List<AnimationController>> _controllers = [];


  final VideosModel model = VideosModel();

  final List<Widget> _pages = <Widget>[];
  late final Future<List<VideosList>> _videos;
  late List _options;

  int _value = 0;

  List<VideosList> videos = [];

  @override
  void initState() {
    super.initState();
    _videos = VideosModel.getVideosList();
  }

  @override
  void dispose() {
    for (var l in _controllers) {
      for (var c in l) {
        c.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _videos,
      builder: (BuildContext context, AsyncSnapshot<List<VideosList>> snapshot) {
        if (snapshot.hasData) {
          List<VideosList> videosList = snapshot.data!;
          _options = videosList;

          if(videosList.isEmpty) {
            return const Center(
              child: Text('no videos'),
            );
          }

            YoutubePlayerController controller = YoutubePlayerController(
                initialVideoId: videosList[0].videos.isNotEmpty ? videosList
                    .first.videos.first.id :
                videosList[1].videos.first.id,
                flags: const YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ));

            _pages.clear();
            for (int j = 0; j < videosList[0].videos.length; ++j) {
              if (!videosList[0].videos[j].isFavorite) {
                videosList[0].videos.removeAt(j);
              }
            }

            for (int i = 0; i < videosList.length; ++i) {
              _controllers.add([]);
              _pages.add(
                  ListView(
                    children: List<Widget>.generate(
                        videosList[i].videos.length, (int index) {
                      _controllers[i].add(AnimationController(vsync: this, duration: const Duration(seconds: 1))
                      );
                      if (videosList[i].videos[index].isFavorite) {
                        _controllers[i][index].reset();
                        _controllers[i][index].animateTo(0.6);
                      }
                      return videosList[i].videos.isNotEmpty ? GestureDetector(

                          onTap: () {
                            controller.load(videosList[i].videos[index].id);
                          },
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(),
                                      borderRadius:
                                      BorderRadius.circular(
                                          20.0), //<-- SEE HERE
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.play_arrow_outlined,
                                          size: 40,
                                        ),
                                        Expanded(
                                          child: Text(
                                            videosList[i].videos[index].title,
                                            style: const TextStyle(
                                              //color: Colors.white,
                                              fontSize: 25,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                              Padding(padding: const EdgeInsets.only(
                                  right: 8, left: 0),
                                child: IconButton(
                                  onPressed: () {
                                    if (!videosList[i].videos[index]
                                        .isFavorite) {
                                      _controllers[i][index].reset();
                                      _controllers[i][index].animateTo(0.6);
                                      setState(() {
                                        videosList[i].videos[index].isFavorite =
                                        !videosList[i].videos[index].isFavorite;
                                        if (videosList[i].videos[index]
                                            .isFavorite) {
                                          videosList[0].videos.add(videosList[i].videos[index]);
                                          VideosModel.addFavorite
                                            (videosList[i].videos[index].id,
                                              videosList[i].videos[index].title);
                                        }
                                      });
                                    } else {
                                      _controllers[i][index].reverse();
                                      videosList[i].videos[index].isFavorite =
                                      !videosList[i].videos[index].isFavorite;
                                      VideosModel.rmFavorite(videosList[i].videos[index].id);
                                    }
                                  },
                                  icon: Lottie.asset(Icons8.heart_color,
                                      controller: _controllers[i][index]),


                                ),
                              )

                            ],
                          )) : const Text('Nothing to show');
                    }),
                  )

              );
            }

            return Scaffold(
                body: Column(children: [
                  YoutubePlayer(
                    controller: controller,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List<Widget>.generate(
                            _options.length, (int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
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
                  Expanded(child: _pages.elementAt(_value)
                  ),
                ]));
          }
          else {
            return const Center(child: CircularProgressIndicator());
          }
        }


    );

  }

}
