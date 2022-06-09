import 'package:flutter/material.dart';
import 'package:fyp/models/Notes.dart';
import 'package:fyp/screens/Lecturer/EditCourse.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../Providers/User.dart';

class WriteNoteL extends StatefulWidget {
  Note note;
  int cindex;
  WriteNoteL({Key? key, required this.note, required this.cindex})
      : super(key: key);

  @override
  State<WriteNoteL> createState() => _WriteNoteLState();
}

class _WriteNoteLState extends State<WriteNoteL> {
  var noteController = TextEditingController();

  void initState() {
    noteController.text = widget.note.content;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final Media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 231, 244, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(124, 131, 253, 1),
        centerTitle: true,
        title: Text(
          widget.note.noteTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.angleLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                user.addNote(
                  widget.note.noteID,
                  DateTime.now().microsecondsSinceEpoch,
                  noteController.text,
                  user.Name,
                  user.id,
                );
              },
              icon: Icon(
                FontAwesomeIcons.plus,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: Media.size.height,
        child: TextField(
          controller: noteController,
          expands: true, // add this line
          minLines: null, // add this line
          maxLines: null,
          keyboardType: TextInputType.multiline,

          decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(255, 147, 150, 210),
            border: const UnderlineInputBorder(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await user.closeNoteSession(
              widget.cindex, widget.note.noteID, widget.note.noteTitle);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EditCourse(
                index: widget.cindex,
              ),
            ),
          );
        },
        backgroundColor: Colors.red,
        child: Icon(Icons.close),
      ),
    );
  }

  
}
