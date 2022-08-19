import 'package:books_library/homePage.dart';
import 'package:books_library/settings.dart';
import 'package:books_library/wishList.dart';
import 'package:flutter/material.dart';
import 'connection.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>{
  int _selectedIndex = 0 ;
  var data;
  List res = [];
  bool dataReceived = false;
  List _pages=[];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async{
    data = await connectionMD();
    setState(() {
      dataReceived = true;
    });
    int i=0;
    for(var item in data){
      item['name'] = item['name'].toLowerCase();
      res.add({'item':item,'isBookmarked':false,'index':i});
      i +=1;
    }
    _pages = [
      HomePage(data: res , addBookmark: addBookMark , removeBookmark: removeBookMark),
      WishList(data: res , removeBookmark: removeBookMark ),
      const Settings()
    ];
  }

  void addBookMark(int index){
      res[index]['isBookmarked'] = true;
  }

  void removeBookMark(int index){
      res[index]['isBookmarked'] = false;
  }

  void _onItemTap(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !dataReceived? const Scaffold(body: Center(child: CircularProgressIndicator(color: Colors.brown,backgroundColor: Color(0xff785532),))) : Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff785532),
        selectedItemColor: const Color(0xffffffff),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmark'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
      body: _pages.elementAt(_selectedIndex)
    );
  }
}
