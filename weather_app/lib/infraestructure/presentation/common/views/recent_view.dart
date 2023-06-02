import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/infraestructure/presentation/common/widgets/custom_appbar.dart';

import '../../../../application/blocs/blocs.dart';
import '../utils/styles.dart';

class RecentView extends StatelessWidget {
  const RecentView({super.key});

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
    return const Column(children: [
      CustomAppBar(
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Recientes', style: TextStyle(color: Colors.white, fontSize: 25)),
      ])),
      SizedBox(height: 10),
      _RecentsListView(),
    ]);
  }
}

class _RecentsListView extends StatelessWidget {
  const _RecentsListView();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.7,
      child: BlocBuilder<RecentBloc, RecentState>(
        builder: (context, state) {
          return ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: state.recents.length,
              itemBuilder: (context, index) {
                if (state.recents.isEmpty) return const Text('');
                return _CustomCard(
                  name: state.recents[index].name,
                  country: state.recents[index].country,
                  region: state.recents[index].region,
                  index: index,
                );
              });
        },
      ),
    );
  }
}

class _CustomCard extends StatelessWidget {
  final String name;
  final String? region;
  final String country;
  final int index;
  const _CustomCard({
    required this.name,
    required this.country,
    required this.region,
    required this.index,
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
            trailing: Wrap(
              children: [
                IconButton.filled(
                    onPressed: () {
                      context
                          .read<WeatherBloc>()
                          .add(LoadWeatherEvent(locationName: '$name $country'));
                      context.go('/');
                    },
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: Colors.white,
                    )),
                IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.red[300]),
                    onPressed: () {
                      context.read<RecentBloc>().add(DeleteLocationOfList(index: index));
                    },
                    icon: const Icon(
                      Icons.delete_outlined,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
