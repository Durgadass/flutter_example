import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/data/wiki_repository_implementation.dart';
import 'package:flutter_example/view/wiki_pages_screen.dart';
import 'package:flutter_example/view/wiki_search_cubit.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Wiki Search",
      home: BlocProvider(
        create: (_) => WikiSearchCubit(WikiRepositoryImplementation()),
        child: WikiPagesScreen(),
      ),
    ),
  );
}
