import 'package:flutter/material.dart';
 class NavBar extends StatefulWidget {
   const NavBar({super.key});

   @override
   State<NavBar> createState() => _NavBarState();
 }

 class _NavBarState extends State<NavBar> {
   @override
   Widget build(BuildContext context) {
     return DefaultTabController(
       length: 5,
       child: Scaffold(
         appBar: AppBar(
           title: Text("Smart Money Handling"),
           backgroundColor: Colors.green[900],
         ),
         backgroundColor: Colors.lightGreen[100],
         body: Padding(
           padding: EdgeInsets.all(8.0),
           child: TabBarView(
             children: [
               // Add your tab content here
             ],
           ),
         ),
         bottomNavigationBar: Container(
           color: Colors.green[900],
           child: TabBar(
             tabs: [
               Tab(
                 icon: Icon(Icons.home),
                 child: Text(
                   'Home',
                   style: TextStyle(fontSize: 10),
                 ),
               ),
               Tab(
                 icon: Icon(Icons.money),
                 child: Text(
                   'Financial\nGoals',
                   style: TextStyle(fontSize: 10),
                   textAlign: TextAlign.center,
                 ),
               ),
               Tab(
                 icon: Icon(Icons.attach_money),
                 child: Text(
                   'Money\nReport',
                   style: TextStyle(fontSize: 10),
                   textAlign: TextAlign.center,
                 ),
               ),
               Tab(
                 icon: Icon(Icons.sticky_note_2_outlined),
                 child: Text(
                   'Reports',
                   style: TextStyle(fontSize: 10),
                   textAlign: TextAlign.center,
                 ),
               ),
               Tab(
                 icon: Icon(Icons.help_outline),
                 child: Text(
                   'Help\nCenter',
                   style: TextStyle(fontSize: 10),
                   textAlign: TextAlign.center,
                 ),
               ),
             ],
             indicator: UnderlineTabIndicator(
               borderSide: BorderSide(color: Colors.white, width: 2.0),
             ),
           ),
         ),
       ),
     );
   }
 }
