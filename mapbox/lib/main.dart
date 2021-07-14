import 'package:flutter/material.dart';
import 'package:flutter_application_1/helper/location.helper.dart';
import 'package:flutter_application_1/provider/map.provider.dart';

import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MapProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    var aaaa = Provider.of<MapProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: currentLocation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Center(child: Consumer<MapProvider>(
                  builder: (context, provider, _) {
                    return MapboxMap(
                      onMapCreated: _onMapCreated,

                      //  (map) {
                      //   final location = snapshot.data;
                      //   final animate = map.animateCamera(
                      //       CameraUpdate.newCameraPosition(CameraPosition(
                      //           zoom: 15, target: provider.mark)));
                      //   if (animate != null) {
                      //     map.addCircle(CircleOptions(
                      //         circleRadius: 15.0,
                      //         geometry: provider.mark,
                      //         circleColor: '#6289ff'));
                      //   }
                      // },
                      onMapClick: (point, latlng) {
                        //  print("$point $latlng");
                        provider.setmark(latlng);
                        print(aaaa.mark);
                        mapController.animateCamera(
                            CameraUpdate.newCameraPosition(CameraPosition(
                                zoom: 15, target: provider.mark)));
                      },
                      accessToken:
                          "pk.eyJ1IjoibWFwYm94OTE1IiwiYSI6ImNrcXVzZmJkZjA3a28ycW82ajI1ajJmMGwifQ.xv6b7gTFg4fYGeFUakuqIA",
                      initialCameraPosition: CameraPosition(
                          zoom: 15,
                          target:
                              LatLng(-6.287901211441309, 107.01133194971663)),
                    );
                  },
                ));
              } else {
                return Text("tidak ada");
              }
            }));
  }
}
