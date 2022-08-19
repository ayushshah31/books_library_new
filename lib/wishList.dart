import 'package:books_library/shadowCard.dart';
import 'package:flutter/material.dart';

import 'bookStats.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key, required this.data , required this.removeBookmark}) : super(key: key);
  final data;
  final Function removeBookmark;
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {

  var reqData;
  bool dataPresent = false;
  @override
  void initState() {
    super.initState();
    reqData = widget.data.where((item) => item['isBookmarked'] == true).toList();
    setState(() {
      if(reqData.length>0) dataPresent = true;
    });
  }

  // @mustCallSuper
  // @protected
  // void reassemble() {
  //   print("Page should reload");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: const Color(0Xffc8c6ad),
        body: !dataPresent? const Center(child: Text("No book added"),)
            : ListView.builder(
              itemCount: reqData.length,
              itemBuilder: (context,index){
                return reqData[index]['isBookmarked']? ListTile(
                  onTap: (){
                    // print(data[index]['item']['image']);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>BookStats(dataBook: reqData[index]['item'],)));
                  },
                  title: ShadowCard(
                    data: reqData[index],
                    pressed: (){
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        widget.removeBookmark(reqData[index]['index']);
                        setState(() {
                          reqData[index]['isBookmarked'] = false;
                        });
                      });
                      },
                    ),
                ): Container();
            }
        )
    );
  }
}
