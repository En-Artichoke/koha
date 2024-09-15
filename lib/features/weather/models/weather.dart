class WeatherModel {
  final int temp;
  final String description;
  final String icon;

  WeatherModel({
    required this.temp,
    required this.description,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['temp'],
      description: json['weather']['description'],
      icon: json['weather']['icon'],
    );
  }
}
