import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/blocs/blocs.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.80,
      height: 50,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.text,
              onChanged: (value) {
                if (value.isEmpty) return;
                context.read<SearchBloc>().add(LocationChangedEvent(location: value));
              },
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Introduce una localidad..',
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  border: UnderlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(Icons.search)));
        },
      ),
    );
  }
}
