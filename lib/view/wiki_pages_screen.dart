import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/domain/page_entry.dart';
import 'package:flutter_example/view/wiki_search_cubit.dart';
import 'package:flutter_example/view/wiki_search_states.dart';
import 'package:url_launcher/url_launcher.dart';

class WikiPagesScreen extends StatefulWidget {
  @override
  _WikiPagesScreenState createState() => _WikiPagesScreenState();
}

class _WikiPagesScreenState extends State<WikiPagesScreen> {
  bool _inSearchMode = false;
  final _textEditingController = TextEditingController();
  List<PageEntry> items = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _textEditingController.addListener(() {
      final text = _textEditingController.text;
      if (text.length >= 3) {
        BlocProvider.of<WikiSearchCubit>(context).searchWiki(text);
      }
    });
    super.initState();
  }

  void _setInSearchMode(bool inSearchMode) {
    if (_inSearchMode != inSearchMode) {
      setState(() {
        _inSearchMode = inSearchMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _inSearchMode
            ? TextField(
                autofocus: true,
                cursorColor: Colors.white,
                controller: _textEditingController,
                decoration: const InputDecoration.collapsed(
                  hintText: "Search anything",
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(color: Colors.white),
              )
            : const Text('Search Wiki'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: BlocBuilder<WikiSearchCubit, WikiSearchCubitState>(
            builder: (_, state) {
              if (state is WikiSearchCubitLoading)
                return const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white));
              else
                return Container();
            },
          ),
        ),
        actions: [
          if (!_inSearchMode)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _onSearchPressed,
            ),
          if (_inSearchMode)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: _onClosePressed,
            ),
        ],
      ),
      body: BlocConsumer<WikiSearchCubit, WikiSearchCubitState>(
        listener: (_, state) {
          if (state is WikiSearchCubitSuccess) {
            items = state.result;
          }
          if (state is WikiSearchCubitFailure) {
            _showFailure();
          }
        },
        builder: (_, state) {
          if (state is WikiSearchCubitInitial) {
            return const Center(
                child: Text('Click search and type three characters'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, index) {
              final page = items[index];
              String url = page.thumbnail;
              if (page.thumbnail != null) {
                if (!page.thumbnail.startsWith('https:')) {
                  url = 'https:${page.thumbnail}';
                }
              }
              return ListTile(
                leading: SizedBox(
                  width: 70,
                  height: 70,
                  child: page.thumbnail == null
                      ? Icon(Icons.image)
                      : Image.network(url),
                ),
                title: Text(page.title),
                subtitle: Text(page.description ?? "No description found"),
                onTap: () => _goToPageInBrowser(page.title),
                contentPadding: const EdgeInsets.all(4),
              );
            },
            itemCount: items.length,
          );
        },
      ),
    );
  }

  void _onSearchPressed() {
    _setInSearchMode(true);
  }

  void _onClosePressed() {
    _setInSearchMode(false);
  }

  void _showFailure() {
    _scaffoldKey.currentState.showSnackBar(
        const SnackBar(content: Text("Something went wrong. Try later.")));
  }

  void _goToPageInBrowser(String title) {
    final url = 'https://en.wikipedia.org/wiki/$title';
    launch(url);
  }
}
