import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import './Pages/Movies.dart';
import './Pages/Shows.dart';
import 'Data/SearchShow.dart';
import 'Data/SearchMovie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMDb Shows',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const Mainscreen(),
    );
  }
}

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.person_2_outlined),
            color: Colors.grey[800],
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Center(child: const Text("V I D S R C", style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: 'Times New Roman') ,)),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(child: SafeArea(child: Expanded(child: Card(
        color: Colors.black,
        child: Center(child: ListView(children: [
          const SizedBox(height: 2),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),child: Center(child: Text("M A S T E R", style: TextStyle(color: Colors.white),))),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: CircleAvatar(backgroundImage: AssetImage('assets/avatar.png')),
                    ),
                    Center(
                      child: Padding(padding: EdgeInsets.all(5.0),
                      child: Text("I S G - 3 2", style: TextStyle(fontSize: 20),),
                      ),
                    )
                  ]),
                  const SizedBox(height: 2),
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(child: Image.asset('assets/Icon_instagram.jpg', scale: 10), onTap: () =>  launch("https://instagram.com/kahaan.ho.sapan")),
                    InkWell(child: Image.asset('assets/Icon_linkedin.jpg', scale: 10), onTap: () =>  launch("https://www.linkedin.com/in/sapan-gajjar-95929222b/")),
                    InkWell(child: Image.asset('assets/Icon_telegram.jpg', scale: 10), onTap: () =>  launch("https://t.me/semisapeol")),
                  ]),
                ],)
              ),
            ),
          ),
          Center(child: Image.asset('assets/genshing.jpg'))
        ],)),
      )))),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(children: [
              Row(
                children: [
                const Card(child: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), 
                child: Text("""

      🛠️ Hello Friend, This is A Home Brewn app
      that, I (isg32) made myself in my mom's basement,
      
      📜 Now you ask what is purpose of this app?
      
      Well for Starters the purpose of this app is to 
      find links to movies that you generally would
      stroll through telegram or some sketchy website
      for, Hence I'd do that for you.

      💬 Make sure to use same name as You'd find in
      IMDB or TMDB sites.

      SeeYa Around, 💖 Radhe (isg32)
      
      """,
        style: TextStyle(fontFamily: 'Times New Roman'),
        )
                )),

          Column(children: [
          
            Row(children: [Card(child: CupertinoButton(child: Column(children: [
                      ClipRRect(child: Image.asset('assets/ficon.jpg', scale: 5), borderRadius: BorderRadius.circular(15)),
                     Text("Movies today", style: TextStyle(fontSize: 30, fontFamily: 'Times New Roman')),
                     const Icon(Icons.arrow_forward_ios)
                    ]), onPressed: (){
                      Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const Movies()),
                    );
                    })),
                    Card(child: CupertinoButton(child: Column(children: [
                      ClipRRect(child: Image.asset('assets/wicon.jpg', scale: 4.5), borderRadius: BorderRadius.circular(15)),
                     Text("Shows today", style: TextStyle(fontSize: 30, fontFamily: 'Times New Roman')),
                     const Icon(Icons.arrow_forward_ios)
                    ]), onPressed: (){
                      Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => const Shows()),
                    );
                    })),]),
                
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                CupertinoButton(child: const Card(
                  child: Padding(
                    padding:  EdgeInsets.all(15),
                    child: Row(
                      children: [
                      Text("Search Movies", style: TextStyle(fontSize: 30, fontFamily: 'Times New Roman')),
                      Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  )
                ), onPressed: (){
                      Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => SearchM()),
                    );
                    }),


                    CupertinoButton(child: const Card(
                  child: Padding(
                    padding:  EdgeInsets.all(15),
                    child: Row(
                      children: [
                      Text("Search Shows", style: TextStyle(fontSize: 30, fontFamily: 'Times New Roman')),
                      Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  )
                ), onPressed: (){
                      Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => SearchS()),
                    );
                    }),

               ],)
                ],)
              ],),

          const Card(child: Padding(padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), 
      child: Text("""

      MIT License

      Copyright (c) 2022 Sapan Gajjar 

      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:

      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.
      
      """, style: TextStyle(fontWeight: FontWeight.w400)))),
               
          
            ],),
          ),
        ),
      ),
    );
    }
}