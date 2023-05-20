import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/blocs/weather_bloc/weather_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.7,
      height: 50,
      child: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return TextFormField(
              autocorrect: false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (_) => (state is ErrorWeatherState) ? state.error : null,
              onFieldSubmitted: (value) {
                if (value.isEmpty) return;
                context.read<WeatherBloc>().add(LoadWeatherEvent(locationName: value));
              },
              decoration: InputDecoration(
                filled: true,
                hintText: 'Introduce una localidad..',
                fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                border: UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
                prefixIcon: const Icon(Icons.search),
              ));
        },
      ),
    );
  }
}
