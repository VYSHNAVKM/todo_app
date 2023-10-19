import 'dart:core';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_screen_controller.dart';
import 'package:todo_app/model/my_name_model.dart';
import 'package:todo_app/view/home_screen/widgets/mycard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeScreenController _noteController = HomeScreenController();
  late List<MyNameModel> _notes = [];
  int existingNoteIndex = -1;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  Color selectedColor = Colors.grey;

  List<Color> colorOptions = [
    Color.fromARGB(255, 245, 225, 94),
    Color.fromARGB(255, 253, 145, 67),
    Color.fromARGB(255, 127, 77, 77),
  ];

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    final notes = await _noteController.loadEvents();
    setState(() {
      _notes = notes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(
          "NOTE",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: _notes.isEmpty
          ? Center(
              child: Text('Empty notes',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w400)),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final dateFormatter = DateFormat('dd-MM-yyyy');
                final note = _notes[index];
                final date = dateFormatter.format(note.date.toLocal());
                return MyCard(
                  onEditPressed: () {
                    existingNoteIndex = index;
                    _addOrEditNote(context, existingNote: note);
                  },
                  onDeletePressed: () async {
                    await _noteController.deleteEvent(index);
                    _loadNotes();
                  },
                  description: note.description,
                  title: note.title,
                  date: date,
                  color: note.color,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          existingNoteIndex = -1;
          _addOrEditNote(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addOrEditNote(BuildContext ctx, {MyNameModel? existingNote}) async {
    final isEditing = existingNote != null;
    final newNote = isEditing
        ? MyNameModel.copy(existingNote)
        : MyNameModel(
            title: '',
            description: '',
            date: DateTime.now(),
            ////
            color: selectedColor.value,
          );

    _titleController.text = newNote.title;
    _descriptionController.text = newNote.description;
    final dateFormatter = DateFormat('dd-MM-yyyy');
    _dateController.text =
        isEditing ? dateFormatter.format(newNote.date.toLocal()) : '';

    int selectedColorIndex =
        isEditing ? colorOptions.indexOf(selectedColor) : -1;

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      isEditing ? 'Edit Note' : 'Add a New Note',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Title'),
                    controller: _titleController,
                    onChanged: (value) {
                      newNote.title = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Description'),
                    controller: _descriptionController,
                    onChanged: (value) {
                      newNote.description = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: newNote.date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          newNote.date = selectedDate.toUtc();
                          _dateController.text =
                              dateFormatter.format(newNote.date.toLocal());
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Date (dd-MM-yyyy)'),
                        controller: _dateController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 80,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 5,
                      children: colorOptions.asMap().entries.map((entry) {
                        final index = entry.key;
                        final color = entry.value;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                              selectedColorIndex = index;
                              newNote.color = color.value;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: index == selectedColorIndex ? 50 : 40,
                              height: index == selectedColorIndex ? 50 : 40,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        onPressed: () async {
                          if (_titleController.text.isNotEmpty &&
                              _descriptionController.text.isNotEmpty) {
                            if (isEditing) {
                              await _noteController.updateEvent(
                                  existingNoteIndex, newNote);
                            } else {
                              await _noteController.addEvent(newNote);
                            }
                            _loadNotes();
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                padding: EdgeInsets.all(20),
                                backgroundColor: Colors.grey,
                                content: Center(
                                    child: Text(
                                  "Please add full details",
                                  style: TextStyle(fontSize: 18),
                                ))));
                          }
                        },
                        child: Text(isEditing ? 'Save' : 'Add'),
                      ),
                      SizedBox(
                        width: 60,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black)),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
