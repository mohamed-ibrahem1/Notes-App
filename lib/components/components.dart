import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import '../main.dart';
import '../models/notes_model.dart';
import '../pages/note_editor.dart';

Widget noteCard(Function()? onTap, Note note) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  note.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: darkTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              IconButton(
                icon: const Icon(
                  FontAwesomeIcons.circleXmark,
                ),
                onPressed: () {
                  note.delete();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            note.note!,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatDate(note.creationDate!, [d, ', ', M, ' ', yyyy]),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

///////////////////////////////////////////// *searchNoteCard* /////////////////////////////////////////////////////
///
///

Widget searchNoteCard(
  Function()? onTap,
  String noteTitle,
  String noteContent,
  DateTime noteDateTime,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(left: 8),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  noteTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: darkTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              // IconButton(
              //   icon: const Icon(Icons.cancel_outlined),
              //   onPressed: () {
              //     deleteNote.delete();
              //   },
              // ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            noteContent,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatDate(noteDateTime, [d, ', ', M, ' ', yyyy]),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////////////
///
/////دة الجزء الي بيعرض النوتس بتاعتي بالشكل بتاعها جوة ال
//GridView
//في شاشة ال
//home_page.dart
///////////////////////

List<Widget> myList(context) {
  return box.values
      .map((note) => noteCard(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                //الحتة بتاعت ال
                //note:
                //دي مهمة جدا عشان من غيرها انت هتدخل علي صفحة ال
                // NoteEditor
                //فاضية مفيهاش الكلام اللي هتعدلة
                builder: (context) => NoteEditor(
                  note: note,
                ),
              ),
            );
          }, note))
      .toList();
}

////////////////////////////////// Colors //////////////////////////////////////////////

Color mainColor = HexColor('#1a1d21');
Color lightTextColor = HexColor('#F0EBE3');
Color darkTextColor = HexColor('#070706');
Color buttonColor = HexColor('#FF7878');
Color cardColor = HexColor('#bac2d3');
