import 'package:flutter/material.dart';

class CardFullScreen extends StatefulWidget {
  CardFullScreen(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.color});

  final String title;
  final String description;
  final String date;
  final Color color;

  @override
  State<CardFullScreen> createState() => _CardFullScreenState();
}

class _CardFullScreenState extends State<CardFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.title,
            style: TextStyle(fontSize: 24, color: Colors.white)),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(widget.date,
                      textAlign: TextAlign.justify,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.description,
                  textAlign: TextAlign.justify, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ]),
    );
  }
}
