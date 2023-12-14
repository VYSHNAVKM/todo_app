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
              border: Border.all(color: Colors.black, width: 3),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70))),
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
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(widget.description,
                      textAlign: TextAlign.justify,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 18)),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      widget.date,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Center(
                            child: IconButton(
                              onPressed: widget.onEditPressed,
                              icon: Icon(
                                Icons.edit,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black, width: 5)),
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: widget.onDeletePressed,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
