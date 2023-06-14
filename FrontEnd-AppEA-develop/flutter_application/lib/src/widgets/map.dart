import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants.dart';
import 'package:flutter_application/utils/controller_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class Map extends StatefulWidget {
  const Map(BuildContext context,{super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {

final _controllerMap=ControllerMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
          body: GoogleMap( //Tiene que estar en un Scaffold o en un SizedBox
            initialCameraPosition: _controllerMap.initialCameraPosition,
            //markers: _controllerMap.markers,
            markers: Constants.markers,
            //myLocationButtonEnabled: true, //Aparece el boton de buscar la ubicacion actual
            //zoomGesturesEnabled: false, //Bloquear el zoom del mapa
            //zoomControlsEnabled: true,  //Ordenar que aparezcan los controles de zoom del mapa
            //scrollGesturesEnabled: false, //Bloquear el movimiento dentro del mapa
            //mapType: MapType.satellite, //Indicar el aspecto del mapa
            // onTap: (position){ //Acciones que sucederan si clicamos. "postion" son las cordenadas donde se han clicado
            //   print(position);
            // },
            // onLongPress: (position){//Acciones que sucederan si mantenemos clicado una posicion. "postion" son las cordenadas donde se han clicado
            //   print(position);
            // },
            //compassEnabled: true, //Que aparezca el widget de la brujula

            ),
    );
  }
}