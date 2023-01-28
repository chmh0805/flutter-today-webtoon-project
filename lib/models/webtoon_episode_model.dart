class WebtoonEpisodeModel {
  final String? thumb;
  final String id, title, rating, date;

  WebtoonEpisodeModel.fromJson(Map<String, dynamic> json)
      : thumb = json['thumb'],
        id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
