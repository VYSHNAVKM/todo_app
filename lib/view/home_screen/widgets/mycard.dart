import 'package:flutter/material.dart';
import 'package:todo_app/view/card_full_screen/card_full_screen.dart';

class MyCard extends StatefulWidget {
  MyCard({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.description,
    required this.title,
    required this.date,
    required this.color,
  });

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;

  final String description;
  final String title;
  final String date;
  final int color;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return CardFullScreen(
                color: Color(widget.color),
                date: widget.date,
                description: widget.description,
                title: widget.title,
              );
            },
          ));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Color(widget.color),
              borderRadius: BorderRadius.circular(20)),
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                      ),
                      onPressed: widget.onDeletePressed,
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(widget.description,
                      textAlign: TextAlign.justify,
                      maxLines: 4,
                      overflow: TextOverflow.fade,
                      style:
                          TextStyle(color: Colors.grey.shade800, fontSize: 20)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: widget.onEditPressed,
                          icon: Icon(
                            Icons.edit,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
