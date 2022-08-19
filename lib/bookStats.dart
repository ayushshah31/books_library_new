import 'package:flutter/material.dart';

class BookStats extends StatefulWidget {
  const BookStats({required this.dataBook});
  final dataBook;
  @override
  State<BookStats> createState() => _BookStatsState();
}

class _BookStatsState extends State<BookStats> {
  var dataBook;

  @override
  void initState() {
    super.initState();
    dataBook = widget.dataBook;
    // print(dataBook);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0Xffc8c6ad),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3), BlendMode.lighten),
                    image: NetworkImage(dataBook['image']),fit: BoxFit.fill)
                  )
                ),
              Container(
                padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dataBook['name'].toString().toUpperCase(), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    Text("${dataBook['desc']}"),
                    Text("\nRating: ${dataBook['rating'].toString()}"),
                    Text("\nLink: ${dataBook['link']}")
                  ],
                )
              ),
            ],
          ),
        ),
    );
  }
}
