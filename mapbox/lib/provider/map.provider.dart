import 'package:flutter/cupertino.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';

class MapProvider extends ChangeNotifier {
  LatLng _mark = new LatLng(-6.287901211441309, 107.01133194971663);
  LatLng get mark => _mark;

  void setmark(LatLng value) {
    this._mark = value;
  }
}
