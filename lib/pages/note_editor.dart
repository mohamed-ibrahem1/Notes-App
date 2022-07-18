import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_notes_application/components/components.dart';
import 'package:hive_notes_application/models/notes_model.dart';
import 'package:hive_notes_application/pages/home_page.dart';

class NoteEditor extends StatefulWidget {
  NoteEditor({this.note, Key? key}) : super(key: key);

  Note? note;
  @override
  State<NoteEditor> createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  @override
  Widget build(BuildContext context) {
    TextEditingController noteTitle = TextEditingController(
        text: widget.note == null ? null : widget.note!.title!);
    TextEditingController noteContent = TextEditingController(
        text: widget.note == null ? null : widget.note!.note!);
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
        //عملنا الحركة بتاعت ال
        //aling
        //عشان نقرب الكلام من سهم الرجوع
        title: Align(
          alignment: const Alignment(-1.34, 0),
          child: Text(
            widget.note == null ? 'New Note' : 'Update Note',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: TextStyle(
                      fontSize: 35,
                      color: lightTextColor,
                    ),
                    controller: noteTitle,
                    cursorColor: lightTextColor,
                    cursorHeight: 38,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontSize: 35,
                        color: lightTextColor,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(
                      fontSize: 20,
                      color: lightTextColor,
                    ),
                    controller: noteContent,
                    cursorColor: lightTextColor,
                    cursorHeight: 28,
                    keyboardType: TextInputType.multiline,
                    minLines: 2,
                    maxLines: 25,
                    decoration: InputDecoration(
                      hintText: 'Type Something...',
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: lightTextColor,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            largeSizeConstraints: BoxConstraints.tightFor(
              width: 90,
              height: 60,
            ),
          ),
        ),
        child: FloatingActionButton.large(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          onPressed: () async {
            // that is very IMPORTANT ***************************************************************************************
            var newNote = Note(
              title: noteTitle.text,
              note: noteContent.text,
              creationDate: DateTime.now(),
              done: false,
            );
            Box<Note> noteBox = Hive.box<Note>('Note');
            if (widget.note != null) {
              widget.note!.title = newNote.title;
              widget.note!.note = newNote.note;
              widget.note!.save();
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else {
              await noteBox.add(newNote);
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
          },
          child: const Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
