import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';
import 'package:koha/core/utils/notifiers.dart';
import 'package:koha/features/weather/models/aqi.dart';
import 'package:koha/features/weather/models/weather.dart';
import 'package:koha/features/weather/notifiers/weather_notifier.dart';

class WeatherWidget extends ConsumerStatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  WeatherWidgetState createState() => WeatherWidgetState();
}

class WeatherWidgetState extends ConsumerState<WeatherWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(weatherAQIProvider.notifier).getWeatherAndAqi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final weatherAqiState = ref.watch(weatherAQIProvider);

    return weatherAqiState.when(
      data: (data) {
        final WeatherModel weatherData = data['weather'];
        final AQIModel aqiData = data['aqi'];
        return CustomPaint(
          painter: DashedBorderPainter(
            allSides: false,
            color: Colors.grey,
            strokeWidth: 1,
            dashWidth: 2,
            dashSpace: 2,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Row(
              children: [
                Row(
                  children: [
                    const Text(
                      'Ajri në Pristine',
                      style: TextStyle(
                        color: Color(0xFF888888),
                        fontSize: 12,
                        fontFamily: 'Avenir LT 55 Roman',
                        fontWeight: FontWeight.w700,
                        height: 0.10,
                        letterSpacing: -0.41,
                      ),
                    ),
                    Text(
                      ' ${aqiData.trend} ${aqiData.aqi} ',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Avenir LT 55 Roman',
                        fontWeight: FontWeight.w700,
                        height: 0.10,
                        letterSpacing: -0.41,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    const Text('Temp.',
                        style: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 12,
                          fontFamily: 'Avenir LT 55 Roman',
                          fontWeight: FontWeight.w700,
                          height: 0.10,
                          letterSpacing: -0.41,
                        )),
                    SizedBox(
                      height: 16,
                      child: SvgPicture.asset(
                        'assets/image/${weatherData.icon}.svg',
                        height: 18,
                      ),
                    ),
                    Text(
                      ' ${weatherData.temp}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Avenir LT 55 Roman',
                        fontWeight: FontWeight.w700,
                        height: 0.10,
                        letterSpacing: -0.41,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
