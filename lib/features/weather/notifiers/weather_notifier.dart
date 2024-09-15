import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:koha/core/utils/repos.dart';
import 'package:koha/features/weather/models/weather.dart';
import '../../../core/utils/notifiers.dart';
import '../models/aqi.dart';

class WeatherAQINotifier
    extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final KohaRepository _repository;

  WeatherAQINotifier(this._repository) : super(const AsyncValue.loading());

  Future<void> getWeatherAndAqi() async {
    state = const AsyncValue.loading();
    try {
      final weatherData = await _repository.getWeather();
      final aqiData = await _repository.getAqi();
      state = AsyncValue.data({
        'weather': WeatherModel.fromJson(weatherData),
        'aqi': AQIModel.fromJson(aqiData),
      });
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

final weatherAQIProvider =
    StateNotifierProvider<WeatherAQINotifier, AsyncValue<Map<String, dynamic>>>(
        (ref) {
  final repository = ref.watch(kohaRepositoryProvider);
  return WeatherAQINotifier(repository);
});
