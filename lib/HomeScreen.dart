import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


List data;
List<String> imgUrl=[];

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  getData() async
  {
    http.Response response = await http.get('https://api.unsplash.com/photos?client_id=FLYaBqwST7BRH55VDAzJJTxZ-2Si1lNwXmuaD7lQbtU&per_page=20');
    if(response.statusCode==200)
    {
      print("Data Retrieved from UnSplash Successful");
      data=json.decode(response.body);
      // print(data);
      setState(() {
        _assign();
      });
    }
    else
    {
      print("No Data Retrieved");
    }
  }

  // _assign(){
  //   print(data.elementAt(1)["urls"]["raw"]);
  // }
  
  _assign(){
    for(var i=0;i<data.length;i++)
    {
      imgUrl.add(data.elementAt(i)["urls"]["regular"]);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Text("Wallpaper",style: TextStyle(color:Colors.black,fontSize: 22,fontWeight: FontWeight.w700),),
            SizedBox(width: 3),
            Text("Hub",style: TextStyle(color:Colors.blue,fontSize: 22,fontWeight: FontWeight.w700),),
          ]
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 400,
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: imgUrl == null ? 0 : imgUrl.length,
                  itemBuilder: (BuildContext context, int index)
                  {
                    return imgUrl == null ? Center(child: CircularProgressIndicator()) : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(imgUrl.elementAt(index)),fit: BoxFit.cover,
                          )
                        ),
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}