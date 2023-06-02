import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/infraestructure/presentation/common/utils/styles.dart';
import 'package:weather_app/infraestructure/presentation/common/widgets/widgets.dart';

import '../../../../application/blocs/blocs.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CustomAppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SearchField(),
            ],
          ),
        ),
        SizedBox(height: 5),
        _LocationList(),
      ],
    );
  }
}

class _LocationList extends StatelessWidget {
  const _LocationList();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.95,
      color: Colors.white,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is LoadedSearchState) {
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: state.locationResult.length,
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemBuilder: ((context, index) {
                return FadeIn(
                  duration: const Duration(seconds: 2),
                  child: _CustomCard(
                    name: state.locationResult[index].name,
                    region: state.locationResult[index].region,
                    country: state.locationResult[index].country,
                  ),
                );
              }),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final String name;
  final String? region;
  final String country;
  const _CustomCard({
    required this.name,
    required this.country,
    required this.region,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(color: Colors.white, fontSize: 15);
    return Container(
      width: double.infinity,
      height: 83,
      decoration: boxContentDecoration,
      child: Column(
        children: [
          ListTile(
              style: ListTileStyle.drawer,
              title: Text(name, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
              subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(region!, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(country,
                    style: const TextStyle(color: Colors.amber),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              ]),
              trailing: SizedBox(
                width: 110,
                child: FilledButton.tonal(
                    onPressed: () {
                      context
                          .read<WeatherBloc>()
                          .add(LoadWeatherEvent(locationName: '$name $country'));
                      context
                          .read<RecentBloc>()
                          .add(AddLocationToRecent(name: name, region: region!, country: country));
                      context.go('/');
                      context.read<SearchBloc>().add(ResetListEvent());
                    },
                    child: const Text('Agregar')),
              )),
        ],
      ),
    );
  }
}
