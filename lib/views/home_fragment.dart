import 'package:cached_network_image/cached_network_image.dart';
import 'package:sercult/app_config.dart';
import 'package:sercult/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

Widget HomeFragment(Function refresh,  BuildContext context){

  /* --- PROPERTIES --- */
  double sizeWidth = MediaQuery.of(context).size.width;
  double sizeHeight = MediaQuery.of(context).size.height;
  final events = Utils.eventsModel;

  /* --- METHODS --- */

  // bannersCarrosel
  Widget bannersCarrosel(context, sizeWidth, sizeHeight){
    final controller = PageController(viewportFraction: 0.95, keepPage: true, initialPage: 1);

    final pages = List.generate(3, (index) =>
      Container(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: CachedNetworkImage(
          imageUrl: events[index]['banner_url'] as String,
          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.centerLeft,
      color: AppConfig.backgroundColor,
      width: sizeWidth,
      child: Stack(
        children: [
          /* banners */
          SingleChildScrollView(
            child: SizedBox(
                height: sizeHeight,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                )
            ),
          ),
          /* bolinhas do scroll */
          Container(height: sizeHeight - 5,
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: controller,
              count: pages.length,
              effect: JumpingDotEffect(
                dotColor: AppConfig.backgroundColor,
                activeDotColor: AppConfig.primaryColor,
                dotHeight: 8,
                dotWidth: 8,
                jumpScale: .7,
                verticalOffset: 15,
              ),
            ),
          ),
        ],
      ),
    );

  }

  // rewardsContainer
  Widget rewardsContainer(){

    const custonLeftBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(50),
      bottomLeft: Radius.circular(50),
    );

    const custonRightBorderRadius = BorderRadius.only(
      topRight: Radius.circular(50),
      bottomRight: Radius.circular(50),
    );

    return Container(
      padding: const EdgeInsets.all(5),
      color: AppConfig.backgroundColor,
      child: Row(
        children: [
          // coins
          Expanded(
              child: Material(
                color: AppConfig.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5),
                  child: InkWell(
                    borderRadius: custonLeftBorderRadius,
                    onTap: (){},
                    child: Ink(
                        height: 70,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [ BoxShadow(blurRadius: .1,color: Colors.grey, offset: Offset(0,0)) ],
                          borderRadius: custonLeftBorderRadius,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  // icon attach_money
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius: BorderRadius.all(Radius.circular(50))
                                    ),
                                    child: const Icon(Icons.attach_money, color:  Colors.white),
                                  ),
                                  // texts legend
                                  const SizedBox(width:10),
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const [
                                        Text('Minhas', style: TextStyle(color: Colors.black54),),
                                        Text('Moedas', style: TextStyle(color: Colors.black54))
                                      ]
                                  ),
                                ],
                              ),
                            ),
                            // text valor
                            Text('180',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.primaryColor
                                )
                            ),
                            const SizedBox(width:5),
                          ],
                        )
                    ),
                  ),
                ),
              )
          ),
          const SizedBox(width: 1),
          // trophy
          Expanded(
              child: Material(
                color: AppConfig.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
                  child: InkWell(
                      onTap: (){},
                      borderRadius: custonRightBorderRadius,
                      child: Ink(
                          height: 70,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [ BoxShadow(blurRadius: .1,color: Colors.grey, offset: Offset(0,0)) ],
                            borderRadius: custonRightBorderRadius,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    // icon trophy
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                      ),
                                      child: const Icon(Icons.emoji_events_outlined, color:  Colors.white),
                                    ),
                                    // texts legend
                                    const SizedBox(width:10),
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                          Text('Meu', style: TextStyle(color: Colors.black54),),
                                          Text('Rank', style: TextStyle(color: Colors.black54))
                                        ]
                                    ),
                                  ],
                                ),
                              ),
                              // text valor
                              Text('1880ª',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: AppConfig.primaryColor
                                  )
                              ),
                              const SizedBox(width:5),
                            ],
                          )
                      )
                  ),
                ),
              )
          )
        ],
      ),
    );
  }

  // cardEvent
  Widget cardEvent(Map event, bool isSubEvent){

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: AppConfig.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // banner do evento
          Stack(children: [
            // imagem
            Container(
              padding: const EdgeInsets.only(left: 10),
              height: sizeHeight * .20,
              child: CachedNetworkImage(
                imageUrl: event['banner_url'],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
                ),
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            // container verde flutuante
            Padding(
                padding: const EdgeInsets.only(top:  10),
                child: Container(
                  width: sizeWidth * .45,
                  height: sizeHeight * .04,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        bottomLeft: Radius.circular(7)
                    ),
                  ),
                  child: Center(
                    child: Text(event['label'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: sizeHeight * .020)
                    ),
                  ),
                )
            ),
            //avaliação e botões de favoritar e compartilhar
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 5, right: 5),
              alignment: const Alignment(0,1),
              height: sizeHeight * .20,
              child: Row(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const SizedBox(width:5),
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
                                event['favorite'] = !event['favorite'];
                                refresh();
                              },
                              child: Icon(event['favorite']? Icons.favorite : Icons.favorite_border , color: AppConfig.primaryColor),
                            ),
                          )


                      )
                    ],
                  )
                ],
              ),
            )

          ]),
          // titulo e horário
          Container(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(event['title'],
                      style: TextStyle(
                          fontSize: sizeHeight * .02,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey
                      )
                  ),
                  Text(event['time'], style: const TextStyle( color: Colors.blueGrey)),
                ]
            ),
          ),
          // localização
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(event['location'],
                textAlign: TextAlign.end,
                style: const TextStyle(color: Colors.blueGrey)
            ),
          )
        ],
      ),
    );
  }

  // eventsContainer
  Widget eventsContainer(List<Map> events, bool isSubEvent, String categoryName){

    final controller = PageController(viewportFraction: (isSubEvent ? 0.6 : 0.8), keepPage: true, initialPage: 1);

    final pages = List.generate(
      events.length, (index) => cardEvent(events[index], isSubEvent),
    );

    return Container(
      color: AppConfig.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // main header
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(categoryName,
                    style: TextStyle(
                        fontSize: sizeHeight * (isSubEvent? .024 : .028),
                        fontWeight: FontWeight.w600,
                        color: Colors.blueGrey
                    )
                ),
                TextButton(
                    onPressed: (){},
                    child: Text('ver mais',
                        style: TextStyle(
                            fontSize: sizeHeight * .02,
                            color: AppConfig.primaryColor
                        )
                    )
                ),
              ],
            ),
          ),
          // eventos
          SingleChildScrollView(
            child: SizedBox(
                height: sizeHeight * .28,
                child: PageView.builder(
                  controller: controller,
                  itemBuilder: (_, index) {
                    return pages[index % pages.length];
                  },
                )
            ),
          )
        ],
      ),
    );
  }

  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
        child: Column(
            children: [
              bannersCarrosel(context, sizeWidth, sizeHeight * 0.23),
              rewardsContainer(),
              eventsContainer(events, false, 'Eventos em Destaque'),
              eventsContainer(events, true, 'Eventos Gratuitos'),
              eventsContainer(events, true, 'Feiras e Festivais'),
              eventsContainer(events, true, 'Shows e Música'),
            ]
        )
    ),
  );
}