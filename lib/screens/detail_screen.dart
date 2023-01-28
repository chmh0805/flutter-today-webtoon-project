import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:today_webtoon/models/webtoon_detail_model.dart';
import 'package:today_webtoon/models/webtoon_episode_model.dart';
import 'package:today_webtoon/services/api_service.dart';
import 'package:today_webtoon/widgets/detail_image_container_widget.dart';
import 'package:today_webtoon/widgets/webtoon_episode_widget.dart';

class DetailScreen extends StatefulWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<WebtoonDetailModel> webtoonDetail;
  late Future<List<WebtoonEpisodeModel>> webtoonEpisodes;
  late SharedPreferences preferences;
  bool isLiked = false;

  Future initPrefs() async {
    preferences = await SharedPreferences.getInstance();
    final likedToons = preferences.getStringList('likedToons');
    if (likedToons == null) {
      await preferences.setStringList('likedToons', []);
    } else {
      if (likedToons.contains(widget.id)) {
        setState(() {
          isLiked = true;
        });
      }
    }
  }

  onHeartTap() async {
    final likedToons = preferences.getStringList('likedToons');
    if (likedToons == null) {
    } else {
      if (isLiked) {
        likedToons.remove(widget.id);
      } else {
        likedToons.add(widget.id);
      }

      await preferences.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    webtoonDetail = ApiService.getToonDetailById(widget.id);
    webtoonEpisodes = ApiService.getLatestEpisodesById(widget.id);
    initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        foregroundColor: Colors.green,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: onHeartTap,
            iconSize: 32,
            icon: Icon(
              color: Colors.red,
              isLiked ? Icons.favorite : Icons.favorite_outline,
            ),
          ),
        ],
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: 45.0,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.id,
                    child: DetailImageContainer(
                      imageUrl: widget.thumb,
                      offset: const Offset(10, 10),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: webtoonDetail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${snapshot.data!.genre} / ${snapshot.data!.age}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          snapshot.data!.about,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: FutureBuilder(
                            future: webtoonEpisodes,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  children: [
                                    for (var webtoonEpisode in snapshot.data!)
                                      WebtoonEpisodeWidget(
                                        webtoonEpisode: webtoonEpisode,
                                        webtoonId: widget.id,
                                      ),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
