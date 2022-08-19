import 'package:flutter/material.dart';

class ShadowCard extends StatefulWidget {
  const ShadowCard({Key? key , required this.data, required this.pressed}) : super(key: key);
  final data;
  final Function() pressed;

  @override
  State<ShadowCard> createState() => _ShadowCardState();
}

class _ShadowCardState extends State<ShadowCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
        ),
        child: Container(
          height: 170,
          decoration: BoxDecoration(
              color: const Color(0xffffffff),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const[
                BoxShadow(
                  color: Colors.brown,
                  // color: Color(0xffbebebe),
                  offset: Offset(10, 10),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ]
          ),
          child: Row(
            children: <Widget>[
              Container(
                // padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 150.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(widget.data['item']['image']),
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.data['item']['name'].toString().toUpperCase(),style: const TextStyle(wordSpacing: 2, fontWeight: FontWeight.bold, color: Colors.black87),),
                  const SizedBox(height: 10,),
                  Text(widget.data['item']['author'],style: const TextStyle(color: Colors.black45)),
                  const SizedBox(height: 5,),
                ],
              )),
              IconButton(
                icon: const Icon(Icons.bookmark_add),
                color: widget.data['isBookmarked']?Colors.red:Colors.black,
                onPressed: widget.pressed
              ),
              const SizedBox(width: 10,)
            ],
          ),
        )
    );
  }
}
