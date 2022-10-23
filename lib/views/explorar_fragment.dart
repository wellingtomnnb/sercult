import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sercult/utils.dart';

import '../app_config.dart';

Widget ExplorarFragment(BuildContext context,Function refresh, mapController){

  LatLng initialCameraPosition = const LatLng(-20.1365756,-40.4441645);

  Set<Marker> markers = {
    Marker( //add marker on google map
      markerId: MarkerId(const LatLng(-20.1258915,-40.1985967).toString()),
      position: const LatLng(-20.1258915,-40.1985967), //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'Casa de Shows DUBAI',
        snippet: 'Casa de Shows',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ),
    Marker( //add marker on google map
      markerId: MarkerId(const LatLng(-20.1395886,-40.206306).toString()),
      position: const LatLng(-20.1395886,-40.206306), //position of marker
      infoWindow: const InfoWindow( //popup info
        title: 'Praça Encontro das Águas',
        snippet: 'Praça Central',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    )
  };

  final List<Map<String, dynamic>> eventsModel = Utils.eventsModel;

  final double widthSize = MediaQuery.of(context).size.width;
  final double heightSize = MediaQuery.of(context).size.height;
  final List<Widget> eventContainer = List.generate(3, (i) => Container(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: widthSize * .85, height: heightSize * .15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [ BoxShadow(blurRadius: 0.5, color: Colors.black54, offset: Offset(.2,1)) ],
        ),
        child: Row(
          children: [
            //imagem
            CachedNetworkImage(
              width: widthSize * .3, height: heightSize * .15,
              imageUrl: eventsModel[i]['banner_url'],
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: imageProvider, fit: BoxFit.cover)
                ),
              ),
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            // textos: distancia, title, location, rating, etc
            const SizedBox(width: 7),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //distancia
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(eventsModel[i]['label'], style: const TextStyle(color: Colors.white))
                ),
                //title & location
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventsModel[i]['title'],
                      style: TextStyle(
                        fontSize: heightSize * .02,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey
                      )
                    ),
                    Text(
                      eventsModel[i]['location'],
                      style: const TextStyle( color: Colors.blueGrey)
                    ),
                  ],
                ),
                //rating & bottons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //stars
                    Row(
                      children: [
                        Icon(eventsModel[i]['stars'] > 0? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                        Icon(eventsModel[i]['stars'] > 1? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                        Icon(eventsModel[i]['stars'] > 2? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                        Icon(eventsModel[i]['stars'] > 3?Icons.star : Icons.star_border_outlined, color: Colors.amber),
                        Icon(eventsModel[i]['stars'] > 4? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                      ],
                    ),
                    //botoões compartilhar, favoritar
                    const SizedBox(width:10),
                    Row(
                      children: [
                        // share bt
                        Container(
                            height: 33,
                            width: 33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                onTap: (){},
                                child: const Icon(Icons.share , color: Colors.blueGrey),
                              ),
                            )
                        ),
                        const SizedBox(width:3),
                        // favorite bt
                        Container(
                            height: 33,
                            width: 33,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                splashColor: AppConfig.primaryColor,
                                onTap: () {
                                  eventsModel[i]['favorite'] = !eventsModel[i]['favorite'];
                                  refresh();
                                },
                                child: Icon(eventsModel[i]['favorite']? Icons.favorite : Icons.favorite_border , color: AppConfig.primaryColor),
                              ),
                            )


                        )
                      ],
                    )
                  ],
                )

              ],
            )
          ],
        ),

    )
    )
  );

  const custonLeftBorderRadius = BorderRadius.only(
    topLeft: Radius.circular(50),
    bottomLeft: Radius.circular(50),
  );

  const custonRightBorderRadius = BorderRadius.only(
    topRight: Radius.circular(50),
    bottomRight: Radius.circular(50),
  );

  return Expanded(
    child: Stack(
      children: [
        GoogleMap( //Map widget from google_maps_flutter package
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomGesturesEnabled: true, //enable Zoom in, out on map
          markers: markers, //markers to show on map
          mapType: MapType.normal, //map type
          initialCameraPosition: CameraPosition( //initial position in map
            target: initialCameraPosition, //initial position
            zoom: 10.0, //initial zoom level
          ),
          onMapCreated: (controller) { //method called when map is created
            mapController = controller;
            refresh();
          },
        ),
        Column(
          children: [
            //distanciamento do topo
            SizedBox(height: heightSize * .56),
            //conteiners [ver lista, filtros]
            Row(
              children: [
                //mini container ver lista
                const SizedBox(width: 10),
                Material(
                  elevation: 0,
                  color: Colors.white.withOpacity(0),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    onTap: (){},
                    child: Ink(
                      height: 40, width: 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [ BoxShadow(blurRadius: 0.5, color: Colors.black54, offset: Offset(.2,1)) ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Text("Ver Lista"),
                          Icon(Icons.list)
                        ],
                      ),
                    ),
                  ),
                ),
                //mini container filtros
                const SizedBox(width: 10),
                Container(
                  height: 40, width: 110,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [ BoxShadow(blurRadius: 0.5, color: Colors.black54, offset: Offset(.2,1)) ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text("Filtros"),
                      Icon(Icons.tune)
                    ],
                  ),
                ),
              ],
            ),
            //lista de eventos
            Container(
                height: heightSize * .16,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: eventsModel.length,
                  itemBuilder: (context, i) => eventContainer[i],
                )
            ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(children: eventContainer),
            // )
          ],
        )

      ],
    ),
  );
}