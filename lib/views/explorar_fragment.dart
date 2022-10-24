import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sercult/main.dart';
import 'package:sercult/utils.dart';

import '../app_config.dart';

class ExplorarFragment extends StatefulWidget {
  const ExplorarFragment({Key? key}) : super(key: key);

  @override
  State<ExplorarFragment> createState() => _ExplorarFragmentState();
}

class _ExplorarFragmentState extends State<ExplorarFragment> {

  GoogleMapController? mapController;
  LatLng initialCameraPosition = const LatLng(-20.1365756,-40.4441645);

  @override
  Widget build(BuildContext context) {
    return Explorar(context);
  }

  Widget Explorar(BuildContext context){

    final List<Map<String, dynamic>> eventsModel = Utils.eventsModel;

    Set<Marker> markers = {
      Marker( //add marker on google map
        markerId: MarkerId(const LatLng(-20.1258915,-40.1985967).toString()),
        position: LatLng(eventsModel[0]['lat'], eventsModel[0]['lng']), //position of marker
        infoWindow: InfoWindow( //popup info
          title: eventsModel[0]['title'],
          snippet: 'Casa de Shows',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ),
      Marker( //add marker on google map
        markerId: MarkerId(const LatLng(-20.1395886,-40.206306).toString()),
        position: LatLng(eventsModel[1]['lat'], eventsModel[1]['lng']), //position of marker
        infoWindow: InfoWindow( //popup info
          title: eventsModel[1]['title'],
          snippet: 'Praça Central',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ),
      Marker( //add marker on google map
        markerId: MarkerId(const LatLng(-20.1395886,-40.206306).toString()),
        position: LatLng(eventsModel[2]['lat'], eventsModel[2]['lng']), //position of marker
        infoWindow: InfoWindow( //popup info
          title: eventsModel[2]['title'],
          snippet: 'Praça Central',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      )
    };


    final double widthSize = MediaQuery.of(context).size.width;
    final double heightSize = MediaQuery.of(context).size.height;
    final List<Widget> eventsContainers = List.generate(eventsModel.length, (i) => _eventContainer(eventsModel[i], widthSize, heightSize));

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
              zoom: 15.0, //initial zoom level
            ),
            onMapCreated: (controller) { //method called when map is created
              mapController = controller;
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 50, height: 50,
                child: Material(
                    color: Colors.red,
                    child: InkWell(
                      onTap: () {
                        _goToLocation();
                      },
                    )),
              ),
              _rowBottons(),
              _cardsEvent(heightSize, eventsModel, eventsContainers)
            ],
          )
        ],
      ),
    );
  }

  Widget _rowBottons(){
    //conteiners [ver lista, filtros]
    return Row(
        children: List.generate(2, (i) => Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Container(
              height: 40, width: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(5),
                child: InkWell(
                  onTap: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(i==0? "Ver Lista" : "Filtros"),
                      Icon(i==0? Icons.list : Icons.tune)
                    ],
                  ),
                ),
              ),
            )
        ))
    );
  }

  ScrollController _scrollController = ScrollController();

  Widget _cardsEvent(heightSize, eventsModel, eventContainer){
    //lista de eventos
    return SizedBox(
        height: heightSize * .18,
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: eventsModel.length,
          itemBuilder: (context, i) => eventContainer[i],
        )
    );
  }

  Widget _eventContainer(event, widthSize, heightSize){
    return Container(
        padding: const EdgeInsets.only(top: 5, left: 10, bottom: 5),
        decoration: BoxDecoration( borderRadius: BorderRadius.circular(5)),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            onTap: (){},
            onLongPress: () => _goToLocation(loc: LatLng(event['lat'], event['lng'])),
            child: Container(
              padding: const EdgeInsets.all(5),
              width: widthSize * .9, height: heightSize * .15,
              child: Row(
                children: [
                  //imagem
                  CachedNetworkImage(
                    width: widthSize * .3, height: heightSize * .15,
                    imageUrl: event['banner_url'],
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
                          child: Text(event['label'], style: const TextStyle(color: Colors.white))
                      ),
                      //title & location
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              event['title'],
                              style: TextStyle(
                                  fontSize: heightSize * .02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey
                              )
                          ),
                          Text(
                              event['location'],
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
                              Icon(event['stars'] > 0? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                              Icon(event['stars'] > 1? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                              Icon(event['stars'] > 2? Icons.star : Icons.star_border_outlined, color: Colors.amber),
                              Icon(event['stars'] > 3?Icons.star : Icons.star_border_outlined, color: Colors.amber),
                              Icon(event['stars'] > 4? Icons.star : Icons.star_border_outlined, color: Colors.amber),
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
                                        setState(() {
                                          event['favorite'] = !event['favorite'];
                                        });
                                      },
                                      child: Icon(event['favorite']? Icons.favorite : Icons.favorite_border , color: AppConfig.primaryColor),
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

            ),
          ),
        )
    );
  }

  void _goToLocation ({LatLng loc = const LatLng(-20.1365756,-40.4441645)}) {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: loc,
      zoom: 20.0,
    )));
  }
}

