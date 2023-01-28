import 'package:flutter/material.dart';
import 'package:today_webtoon/models/webtoon_episode_model.dart';
import 'package:today_webtoon/widgets/detail_image_container_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WebtoonEpisodeWidget extends StatelessWidget {
  final WebtoonEpisodeModel webtoonEpisode;
  final String webtoonId;

  const WebtoonEpisodeWidget({
    Key? key,
    required this.webtoonEpisode,
    required this.webtoonId,
  }) : super(key: key);

  void onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${webtoonEpisode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            10,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 7,
              bottom: 3,
            ),
            child: GestureDetector(
              onTap: () {
                onButtonTap();
              },
              child: Column(
                children: [
                  DetailImageContainer(
                    imageUrl: webtoonEpisode.thumb,
                    offset: const Offset(3, 3),
                  ),
                  Row(
                    children: [
                      Text(
                        webtoonEpisode.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
