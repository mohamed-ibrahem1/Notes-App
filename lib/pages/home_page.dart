import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notes_application/models/notes_model.dart';
import 'package:hive_notes_application/pages/search_page.dart';
import '../components/components.dart';
import 'note_editor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SearchPage(),
                  ),
                );
              },
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
        backgroundColor: mainColor,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: mainColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Notes',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //********************************************************************************************** */
      //السطر اللي تحت دة مهم جدا عشان هو دة اللي بيسمع في الابلكيشن و يحذف و يضيف في نفس اللحظة 
      //********************************************************************************************** */
      body: ValueListenableBuilder<Box<Note>>(
        valueListenable: Hive.box<Note>('Note').listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: myList(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            largeSizeConstraints: BoxConstraints.tightFor(
              width: 70,
              height: 70,
            ),
          ),
        ),
        child: FloatingActionButton.large(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditor(),
              ),
            );
          },
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}
