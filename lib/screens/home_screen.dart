import 'package:flutter/material.dart';
import 'package:today_webtoon/models/webtoon_model.dart';
import 'package:today_webtoon/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
            return const Text("There is data!");
          } else if (snapshot.hasError) {
            return const Text("Error !!");
          }
          return const Text("Data is Loading...");
        },
        future: webtoons,
      ),
    );
  }
}
