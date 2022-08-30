import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() {
  runApp(
      const MaterialApp(
          debugShowCheckedModeBanner: false, //remove borda de debug
          home: Home()
      )
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  /* --- PROPERTIES --- */
  final Color primaryColor = Colors.pink.shade400;
  final Color backgroundColor = Colors.grey.shade100;

  // Tabs Buttons
  final List<Tab> _tabs = [
    const Tab(icon: Icon(Icons.home)),
    const Tab(icon: Icon(Icons.map)),
    const Tab(icon: Icon(Icons.favorite)),
    const Tab(icon: Icon(Icons.notifications)),
    const Tab(icon: Icon(Icons.person)),
  ];

  /* --- BUILDER --- */
  @override
  Widget build(BuildContext context) {
    // Screen Fragments
    List<Widget> _views = [
      homeFragment(),
      const Center(child: Text('Content of Tab Two')),
      const Center(child: Text('Content of Tab Three')),
      const Center(child: Text('Content of Tab four')),
      const Center(child: Text('Content of Tab five')),
    ];

    return DefaultTabController(
      length: 5,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: topBar(),
          body: TabBarView(children: _views,physics: const BouncingScrollPhysics()),
          bottomNavigationBar: TabBar(
            labelColor: primaryColor,
            unselectedLabelColor: Colors.black54,
            indicatorColor: primaryColor,
            tabs: _tabs
          )
        ),
      )
    );
  }

  /* --- WIDGETS --- */
  PreferredSizeWidget topBar(){
    final searchController = TextEditingController();

    final double statusbarHeight = MediaQuery.of(context).padding.top;
    const double toolbarHeight = 100;

    return AppBar(elevation: 1.5,
        toolbarHeight: toolbarHeight,
        flexibleSpace: Container(
            height: statusbarHeight + toolbarHeight,
            padding: EdgeInsets.only(top: statusbarHeight + 7, right: 15, left: 15),
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(image: AssetImage("images/home_background.png"), fit: BoxFit.cover),
            ),
            child: Column(
                children: [
                  SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Viva a Cultura...',
                              textAlign: TextAlign.left,
                              style: TextStyle(color: primaryColor, fontSize: 22, fontWeight: FontWeight.w600)),
                          Image.asset("images/logo.png")
                        ],
                      )
                  ),
                  SizedBox(height: statusbarHeight * 0.3),
                  SizedBox(
                    height: 33,
                    child: TextField(
                      maxLines: 1,
                      autofocus: false,
                      controller: searchController,
                      onChanged: (text){ setState(()=> searchController );},
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: 'Eventos, Locais, Centros Culturais...',
                          fillColor: Colors.white, filled: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                          enabledBorder: customedOutlineInputBorder(),
                          focusedBorder: customedOutlineInputBorder(),
                          border: customedOutlineInputBorder(),
                          prefixIcon: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.withOpacity(0),
                            child: InkWell(onTap: (){},
                              child: IconButton(
                                  splashRadius: 20,
                                  color: primaryColor,
                                  icon: const Icon(Icons.search, size: 17),
                                  tooltip: 'Pesquisar',
                                  onPressed: () {}
                                /*Navigator.of(context).push(MaterialPageRoute(builder: (context) => ManutencaoPage()));*/
                              ),
                            ),
                          ),
                          suffixIcon: Material(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.red.withOpacity(0),
                            child: InkWell(onTap: (){},
                              child:IconButton(
                                  splashRadius: 20,
                                  color: primaryColor,
                                  icon: searchController.text.isEmpty ? Container() : const Icon(Icons.close, size: 17),
                                  tooltip: 'Limpar',
                                  onPressed: () => searchController.clear()
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ]
            )
        )
    );
  }

  Widget homeFragment(){
    double sizeWidth = MediaQuery.of(context).size.width;
    double sizeHeight = MediaQuery.of(context).size.height;

    // bannersCarrosel
    Widget bannersCarrosel(context, sizeWidth, sizeHeight){
      final controller = PageController(viewportFraction: 0.95, keepPage: true);
      var bannerUrl = 'https://www.instagram.com/p/Cezn0rWNu9Z/media/?size=l';
      var bannerUrl2 = 'https://www.instagram.com/p/CeEOexNL3hq/media/?size=l';
      var bannerUrl3 = 'https://www.instagram.com/p/Ceob-TErTeZ/media/?size=l';

      final banners = [bannerUrl, bannerUrl2, bannerUrl3];
      final pages = List.generate(
        banners.length, (index) => Container(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: CachedNetworkImage(
            imageUrl: banners[index],
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );

      return Container(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        alignment: Alignment.centerLeft,
        color: backgroundColor,
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
                  dotColor: backgroundColor,
                  activeDotColor: primaryColor,
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
        color: backgroundColor,
        child: Row(
          children: [
            // coins
            Expanded(
              child: Material(
                color: backgroundColor,
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
                                  color: primaryColor
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
                color: backgroundColor,
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
                                  color: primaryColor
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
    Widget cardEvent(Map event){

      return Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // banner do evento
            Stack(children: [
              // imagem
              Container(
                padding: const EdgeInsets.only(left: 10),
                height: sizeHeight * .20,
                width: sizeWidth * .85,
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
              child: const Text('Serra - Sede',
                  textAlign: TextAlign.end,
                  style: TextStyle(color: Colors.blueGrey)
              ),
            )
          ],
        ),
      );
    }

    // eventsContainer
    Widget eventsContainer(){

      final controller = PageController(viewportFraction: 0.8, keepPage: true);
      var events = [
        {
          'title':'Festa de São Benedito',
          'label': '1,0 KM. Hoje. GRATIS',
          'time': '17:30',
          'location': 'Serra - Sede',
          'banner_url': 'https://www.instagram.com/p/Cezn0rWNu9Z/media/?size=l'
        },
        {
          'title':' Show Gustavo Lima',
          'label': '7,9 KM. Hoje. GRATIS',
          'time': '20:30',
          'location': 'Laranjeiras - ES',
          'banner_url': 'https://www.instagram.com/p/CeEOexNL3hq/media/?size=l'
        },
        {
          'title':' Aula de Dança',
          'label': '200 M. Hoje. GRATIS',
          'time': '16:30',
          'location': 'Jacaraípe - ES',
          'banner_url': 'https://www.instagram.com/p/Ceob-TErTeZ/media/?size=l'
        },
      ];

      final pages = List.generate(
        events.length, (index) => cardEvent(events[index]),
      );

      return Container(
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // main header
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Eventos em Destaque',
                    style: TextStyle(
                      fontSize: sizeHeight * .028,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueGrey
                    )
                  ),
                  Text('ver mais',
                    style: TextStyle(
                      fontSize: sizeHeight * .02,
                      color: primaryColor
                    )
                  ),
                ],
              ),
            ),
            // eventos
            SingleChildScrollView(
              child: SizedBox(
                  height: sizeHeight * .3,
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
                eventsContainer(),
                eventsContainer(),
                eventsContainer(),
              ]
          )
      ),
    );

  }

  InputBorder customedOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: primaryColor)
    );
  }
}
