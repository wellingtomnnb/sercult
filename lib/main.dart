import 'package:flutter/material.dart';
import 'package:sercult/app_config.dart';
import 'package:sercult/views//home_fragment.dart';
import 'package:sercult/views//home_top_bar.dart';
import 'package:sercult/views/explorar_fragment.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
  static const tabfontSize = 12.0;
  // Tabs Buttons
  final List<Tab> _tabs = const [
    Tab(iconMargin: EdgeInsets.all(0), icon: Icon(Icons.home), child: Text('Início', style: TextStyle(fontSize: tabfontSize))),
    Tab(iconMargin: EdgeInsets.all(0), icon: Icon(Icons.map), child: Text('Explorar', style: TextStyle(fontSize: tabfontSize))),
    Tab(iconMargin: EdgeInsets.all(0), icon: Icon(Icons.favorite), child: Text('Favoritos', style: TextStyle(fontSize: tabfontSize))),
    Tab(iconMargin: EdgeInsets.all(0), icon: Icon(Icons.notifications), child: Text('Notificações', style: TextStyle(fontSize: tabfontSize))),
    Tab(iconMargin: EdgeInsets.all(0), icon: Icon(Icons.person), child: Text('Perfil', style: TextStyle(fontSize: tabfontSize))),
  ];

  //controller for Google map
  GoogleMapController? mapController;

  void refresh() => setState(() {});

  /* --- BUILDER --- */
  @override
  Widget build(BuildContext context) {

    // Screen Fragments
    List<Widget> _views = [
      HomeFragment(refresh, context),
      const ExplorarFragment(),
      Container(
        child: Expanded(child: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            width: 15,
            height: 15,
            color: Colors.white.withOpacity(0.0),
          ),
          color: Colors.red,
        )
        ),
      ),
      const Center(child: Text('Content of Tab four')),
      const Center(child: Text('Content of Tab five')),
    ];

    return DefaultTabController(
      length: 5,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: topBar(context),
            body: TabBarView(children: _views, physics: const NeverScrollableScrollPhysics()),
            // body: TabBarView(children: _views, physics: const BouncingScrollPhysics()), //rolagem entre telas otiva
          bottomNavigationBar: Container(
            height: MediaQuery.of(context).size.height * .07,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [ BoxShadow(blurRadius: 1, color: Colors.black45, offset: Offset(0,-.01)) ],
            ),
            child: TabBar(
                labelPadding: EdgeInsets.zero,
                labelColor: AppConfig.primaryColor,
                unselectedLabelColor: Colors.black54,
                indicatorColor: AppConfig.primaryColor,
                tabs: _tabs,
            ),
          )
        ),
      )
    );
  }


}
