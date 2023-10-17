import 'package:flutter/material.dart';
import 'package:todo_app/controller/home_screen_controller.dart';
import 'package:todo_app/model/my_name_model.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

HomeScreenController notecontroller = HomeScreenController();

class _EditScreenState extends State<EditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int selectedcolor = 0xFF0000;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = ("${selectedDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('EDIT CARD'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  hintText: 'Description', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        shadows: [Shadow(color: Colors.black, blurRadius: 5)],
                        size: 45,
                      ),
                      hintText: 'Date',
                      border: OutlineInputBorder()),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int colorValue in [
                  0xFEFAEBD7,
                  0xFFBDB76B,
                  0xFFA9A9A9,
                ])
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedcolor = colorValue;
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(colorValue),
                        // border: Border.all(
                        //   color: selectedColor == colorValue
                        //       ? Colors.grey
                        //       : Colors.white,
                        //   width: 2,
                        // ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_titleController.text.isEmpty &&
                      _descriptionController.text.isEmpty) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Center(child: Text('Please add correct value')),
                      ),
                    );
                  } else {
                    notecontroller.addEvent(
                      MyNameModel(
                        date: selectedDate,
                        description: _descriptionController.text,
                        title: _titleController.text,
                        selectColor: selectedcolor,
                      ),
                    );
                    Navigator.pop(context);
                  }
                });
              },
              child: Text('UPDATE'),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
