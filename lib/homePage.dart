import 'package:books_library/bookStats.dart';
import 'package:books_library/shadowCard.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.data ,required this.addBookmark, required this.removeBookmark}) : super(key: key);
  var data;
  Function addBookmark;
  Function removeBookmark;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var data;
  int length=0;
  bool dataReceived=false;
  late Function addBookmark;
  late Function removeBookmark;
  var searchData;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    data = widget.data;
    searchData = data;
    length = data.length;
    addBookmark = widget.addBookmark;
    removeBookmark = widget.removeBookmark;
  }

  void searchBar(String text){
    // print(text);
    // print(data.where((book) =>
    //     book['item']['name'].contains(text)==true || book['item']['author'].contains(text)==true));
    setState(() {
      try {
        searchData = data.where((book) =>
            book['item']['name'].contains(text)==true || book['item']['author'].contains(text)==true).toList();
      }
      catch(e){
        searchData = data;
        // print("Error + $e");
      }
    });
    // print(searchData.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0Xffc8c6ad),
      appBar: AppBar(
        actions: const [Icon(Icons.add,color: Color(0xffdf9f6c),),SizedBox(width: 10,)],
        title: Row(
          children: const <Widget>[
            Icon(Icons.wifi,color: Color(0xffdf9f6c),),
            SizedBox(width: 10,),
            Icon(Icons.import_export_outlined,color: Color(0xffdf9f6c)),
            SizedBox(width: 100,),
            Text("LIBRARY")
          ],
        ),
      ),

      body: Column(
        children: <Widget>[
          //Search bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0Xffffffff),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 35,
              child: Row(
                children: <Widget>[
                  const SizedBox(width: 30,),
                  const Icon(Icons.search,color: Color(0xffdf9f6c),),
                  const SizedBox(width: 15),
                  TextField(
                    controller: textController,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      constraints: const BoxConstraints(maxHeight: 30,maxWidth: 300),
                        hintText: "Search in Library",
                        hintStyle: TextStyle(color: Colors.grey[500])),
                    onChanged: searchBar,
                    // onSubmitted: searchBar,
                  ),
                ],
              ),
            ),
          ),

          //Books
          Flexible(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: searchData.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>BookStats(dataBook: searchData[index]['item'],)));
                    },
                    title: ShadowCard(
                        data: searchData[index],
                        pressed: (){
                          WidgetsBinding.instance.addPostFrameCallback((_){
                            if(!searchData[index]['isBookmarked']) {
                              addBookmark(searchData[index]['index']);
                              setState(() {
                                searchData[index]['isBookmarked'] = true;
                              });
                            }
                            else {
                              removeBookmark(searchData[index]['index']);
                              setState(() {
                                searchData[index]['isBookmarked'] = false;
                              });
                            }
                          });
                        },
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }
}
