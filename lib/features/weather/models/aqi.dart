class AQIModel {
  final String trend;
  final int aqi;

  AQIModel({
    required this.trend,
    required this.aqi,
  });

  factory AQIModel.fromJson(Map<String, dynamic> json) {
    return AQIModel(
      trend: json['trend'],
      aqi: json['aqi'],
    );
  }
}
