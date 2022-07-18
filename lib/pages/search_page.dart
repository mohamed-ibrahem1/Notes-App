import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/adapters.dart';

import '../components/components.dart';
import '../main.dart';
import '../models/notes_model.dart';
import 'note_editor.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List displayList = List.from(box.values);

  void updateList(String value) {
    setState(() {
      displayList = box.values
          .where((element) =>
              element.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        leading: IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Align(
          alignment: Alignment(-1.2, 0),
          child: Text(
            'Search',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: Hive.box<Note>('Note').listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  onChanged: (value) => updateList(value),
                  controller: searchController,

                  //السطر اللي تحت دة عشان يفتح الكيبورد من نفسة
                  autofocus: true,
                  style: TextStyle(
                    color: HexColor('ececec'),
                  ),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      color: Colors.white,
                      onPressed: () {
                        searchController.clear();
                      },
                      icon: const Icon(
                        FontAwesomeIcons.xmark,
                      ),
                    ),
                    hoverColor: HexColor('ececec'),
                    fillColor: HexColor('292a35'),
                    hintStyle: TextStyle(
                      color: HexColor('ececec'),
                    ),
                    hintText: 'Search here . . . .',
                    prefixIcon: Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: HexColor('ececec'),
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: displayList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                FontAwesomeIcons.noteSticky,
                                color: Colors.white,
                                size: 100,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Nothing found',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: displayList.length,
                          itemBuilder: (context, index) {
                            return searchNoteCard(
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NoteEditor(
                                      note: displayList[index],
                                    ),
                                  ),
                                );
                              },
                              displayList[index].title,
                              displayList[index].note,
                              displayList[index].creationDate,
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
