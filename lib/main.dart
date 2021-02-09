import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meesho',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Meesho'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.data = [{'image1':'assets/1.jpg','image2':'assets/2.jpg','image3':'assets/3.jpg','title':'Mens Tshirts1'},{'image1':'assets/4.jpg','image2':'assets/5.jpg','image3':'assets/6.jpg','title':'Mens Tshirt2'},{'image1':'assets/7.jpg','image2':'assets/8.jpg','image3':'assets/9.jpg','title':'Mens Tshirts3'}];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),),
        backgroundColor: Colors.white70,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for(var i = 0 ; this.data.length > i ; i++)
                Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 400,
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        childAspectRatio: .5,
                        crossAxisCount: 2 ,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        children: [
                          Image(image: AssetImage(this.data[i]['image1']),fit: BoxFit.cover, height: 400),
                          GridView.count(
                            scrollDirection: Axis.horizontal,

                            childAspectRatio: .5,
                            crossAxisCount: 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            children: [
                              Image(image: AssetImage(this.data[i]['image2']),fit: BoxFit.cover),
                              Image(image: AssetImage(this.data[i]['image3']),fit: BoxFit.cover),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(this.data[i]['title'], style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              // side: BorderSide(color: Colors.red)
                          ),
                          onPressed: () async {
                            final ByteData bytes1 = await rootBundle.load(this.data[i]['image1']);
                            final ByteData bytes2 = await rootBundle.load(this.data[i]['image2']);
                            final ByteData bytes3 = await rootBundle.load(this.data[i]['image3']);
                            try {
                              await Share.files('esys images',
                                  {
                                    'image1.jpg': bytes1.buffer.asUint8List(),
                                    'image2.jpg': bytes2.buffer.asUint8List(),
                                    'image3.jpg': bytes3.buffer.asUint8List(),
                                  },
                                  '*/*',
                                  text: this.data[i]['title']);
                            } catch (e) {
                              print('error: $e');
                            }

                            // var request = await HttpClient().getUrl(Uri.parse('https://shop.esys.eu/media/image/6f/8f/af/amlog_transport-berwachung.jpg'));
                            // var response = await request.close();
                            //

                            //
                            // await Share.files(
                            //     'esys images',
                            //     {
                            //       'esys.png': bytes1.buffer.asUint8List(),
                            //       'bluedan.png': bytes2.buffer.asUint8List(),
                            //       'addresses.csv': bytes3.buffer.asUint8List(),
                            //     },
                            //     '*/*',
                            //     text: 'My optional text.');

                          },
                          color: Colors.green,
                          textColor: Colors.white,
                          child: Row(
                            children: [
                              Image(image: AssetImage('assets/whatsapp.png'),width: 25,),
                              Text("Share now".toUpperCase(),
                                  style: TextStyle(fontSize: 14)),
                            ],
                          )

                        ),
                      ],
                    ),
                    SizedBox(height: 50,),

                  ],
                ),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
