import 'package:flutter/material.dart';
import 'package:project/model/mountain.dart';
import 'package:project/widget/color.dart';
import 'package:project/widget/largetext.dart';
import 'package:project/widget/smalltext.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.mountain}) : super(key: key);
  final Mountain mountain;
  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    // VideoPlayerController를 저장하기 위한 변수를 만듭니다. VideoPlayerController는
    // asset, 파일, 인터넷 등의 영상들을 제어하기 위해 다양한 생성자를 제공합니다.
    var url = widget.mountain.video;
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: const YoutubePlayerFlags(
            mute: false, loop: false, autoPlay: false));
    super.initState();
  }

  @override
  void dispose() {
    // 자원을 반환하기 위해 VideoPlayerController를 dispose 시키세요.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: double.maxFinite,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(widget.mountain.url),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back,
                                color: AppColor.darkTeal),
                          ),
                          const SizedBox(width: 80),
                          LargeText(
                            text: widget.mountain.name,
                            color: AppColor.darkTeal,
                            size: 30,
                          )
                        ],
                      ),
                      const SizedBox(height: 50),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              LargeText(
                                  text: "Video", color: AppColor.darkTeal),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 50,
                                height: 50,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_controller.value.isPlaying) {
                                        _controller.pause();
                                      } else {
                                        _controller.play();
                                      }
                                    });
                                  },
                                  child: Icon(
                                    _controller.value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      const SizedBox(height: 5),
                      YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller,
                        ),
                        builder: (context, player) {
                          return player;
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                          alignment: Alignment.topLeft,
                          child: LargeText(
                              text: "About", color: AppColor.darkTeal)),
                      const SizedBox(height: 5),
                      Container(
                        height: 200,
                        width: 500,
                        decoration: BoxDecoration(
                            color: AppColor.light,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SmallText(
                              text: widget.mountain.detail,
                              color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
