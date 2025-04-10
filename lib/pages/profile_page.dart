import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(children: [
        CircleAvatar(radius: 70), Text("Naveen Kumar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
        
        ListTile(leading: Icon(Icons.info),title: Text("About"),),
        ListTile(leading: Icon(Icons.info),title: Text("About"),),
        ListTile(leading: Icon(Icons.info),title: Text("About"),),
        ]),
    );
  }
}
