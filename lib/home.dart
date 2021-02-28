import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_tok/widgets/bottom_toolbar.dart';
import 'package:tik_tok/widgets/actions_toolbar.dart';
import 'package:tik_tok/widgets/video_description.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget get topSection => Container(
        height: 70,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Following'),
            Container(
              width: 15.0,
            ),
            Text(
              'For You',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );

  Widget get middleSection => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            VideoDescription(),
            ActionsToolbar(),
          ],
        ),
      );

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/videos/tikTokVideo2.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.purple,
              margin: EdgeInsets.only(bottom: BottomToolbar.NavigationIconSize),
              child: VideoPlayer(_controller),
            ),
            Column(
              children: [
                topSection,
                middleSection,
                BottomToolbar(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

