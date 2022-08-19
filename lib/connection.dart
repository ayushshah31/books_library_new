import 'package:mongo_dart/mongo_dart.dart';

Future<dynamic> connectionMD() async{
  var db = await Db.create('mongodb+srv://ayush:ayushshah@cluster0.wwz8nww.mongodb.net/Books?retryWrites=true&w=majority');
  await db.open();
  var collection = db.collection('book');
  var data = await collection.find().toList();
  // print(data);
  return data;
}