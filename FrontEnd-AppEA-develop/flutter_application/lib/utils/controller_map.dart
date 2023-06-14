import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:flutter_application/utils/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

 class ControllerMap extends ChangeNotifier {
  final Map<MarkerId, Marker> _marker = {};
  Set<Marker> get marker => _marker.values.toSet();
  

  final initialCameraPosition =  CameraPosition(
    target: Constants.markers.isNotEmpty?Constants.markers.first.position:const LatLng(0,0),//Constants.markersMap.isNotEmpty?Constants.markersMap[const MarkerId("0")]!.position:const LatLng(0,0),
    zoom: 13,
  );

  //onTap Mapa
  void onTap(LatLng position ){
    final marker=Marker(markerId:  const MarkerId("0"),
    position: position,);
    _marker[const MarkerId("0")]=marker;
    notifyListeners();
    

  }
}
