class Weather {
  String city;
  String date;
  String condition;
  int maxTemp;
  int minTemp;

  factory Weather.fromJson(Map<String, dynamic> jsonMap) {
    return Weather(
        city: jsonMap['results']['city'],
        date: jsonMap['results']['forecast'][0]['date'],
        condition: jsonMap['results']['forecast'][0]['description'],
        maxTemp: jsonMap['results']['forecast'][0]['max'],
        minTemp: jsonMap['results']['forecast'][0]['min']);
  }

  Weather({this.city, this.date, this.condition, this.maxTemp, this.minTemp});
}
