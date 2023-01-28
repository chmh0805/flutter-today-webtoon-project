import 'package:flutter/material.dart';
import 'package:today_webtoon/models/webtoon_model.dart';
import 'package:today_webtoon/services/api_service.dart';
import 'package:today_webtoon/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        foregroundColor: Colors.green,
        elevation: 1,
        title: const Text(
          "Today's toons",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          // snapshot: state of Future
          if (snapshot.hasData) {
            return Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: makeList(snapshot),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Text("Error !!");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        future: webtoons,
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
