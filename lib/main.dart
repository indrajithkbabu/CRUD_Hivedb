
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main()async {
 WidgetsFlutterBinding.ensureInitialized(); 
  Directory document=await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>('friends');
  
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'hivedb',
    home: ScreenHome(),
  ));
}

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
 late  Box<String> friendsBox;
  final TextEditingController _idController =TextEditingController();
  final TextEditingController _nameController =TextEditingController();

  @override
  void initState() {
    friendsBox =Hive.box<String>("friends");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: friendsBox.listenable(),
              builder: (context, Box<String>friends, _) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    final key =friends.keys.toList()[index];
                    final value =friends.get(key);
                    return ListTile(
                      title: Text("$value",style: TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('$key'),

                    );
                  },
                   separatorBuilder: (_,index){
                    return Divider();
                   }, 
                   itemCount:friends.keys.toList().length);
                
              },

              
             
            ) 
                 ),
                 Padding(
                   padding: const EdgeInsets.all(15.0),
                   child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(onPressed: (){
                          showDialog(context: context,
                           builder: (_){
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize:MainAxisSize.min ,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Enter a  key'
                                      ),
                                      controller: _idController,
                                      
                                    ),
                                    SizedBox(height: 15,),
                                    TextField(
                                        decoration: InputDecoration(
                                        labelText: 'Enter name'
                                      ),
                                      controller: _nameController,
                                    ),
                                    TextButton(
                                     
                                      onPressed: (){
                                         final key =_idController.text;
                                          final value =_nameController.text;
                                          _idController.clear();
                                          _nameController.clear();
                                      friendsBox.put(key, value);
                                      Navigator.pop(context);
                                    }, child: Text('Submit'))
                                  ],
                                ),
                              ),
                            );
                           });

                        }, child: Text('Add new')),

                         ElevatedButton(onPressed: (){
                            showDialog(context: context,
                           builder: (_){
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize:MainAxisSize.min ,
                                  children: [
                                    TextField(
                                        decoration: InputDecoration(
                                        labelText: 'Enter referred  key'
                                      ),
                                      controller: _idController,
                                      
                                    ),
                                    SizedBox(height: 15,),
                                    TextField(  decoration: InputDecoration(
                                        labelText: 'Enter name'
                                      ),
                                      
                                      controller: _nameController,
                                    ),
                                    TextButton(
                                     
                                      onPressed: (){
                                         final key =_idController.text;
                                          final value =_nameController.text;
                                          _idController.clear();
                                          _nameController.clear();
                                      friendsBox.put(key, value);
                                      Navigator.pop(context);
                                    }, child: Text('Submit'))
                                  ],
                                ),
                              ),
                            );
                           });
                          

                        }, child: Text('Update')),

                         ElevatedButton(onPressed: (){
                             showDialog(context: context,
                           builder: (_){
                            return Dialog(
                              child: Container(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  mainAxisSize:MainAxisSize.min ,
                                  children: [
                                    TextField(
                                        decoration: InputDecoration(
                                        labelText: 'Enter referred key'
                                      ),
                                      controller: _idController,
                                      
                                    ),
                                
                                    TextButton(
                                      
                                      
                                     
                                      onPressed: (){
                                         final key =_idController.text;
                                         
                                          _idController.clear();
                                          _nameController.clear();
                                      friendsBox.delete(key);
                                      Navigator.pop(context);
                                    }, child: Text('Submit'))
                                  ],
                                ),
                              ),
                            );
                           });

                        }, child: Text('Delete')),
                        

                      ],
                    ),
                   ),
                 )
        ],
      ),
    );
  }
}