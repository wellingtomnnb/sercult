import 'package:flutter/material.dart';
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

  final searchController = TextEditingController();
  double sideLength = 50;

  @override
  Widget build(BuildContext context) {

    final double statusbarHeight = MediaQuery.of(context).padding.top;
    const double toolbarHeight = 100;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
              toolbarHeight: toolbarHeight,
              flexibleSpace: Container(
                  height: statusbarHeight + toolbarHeight,
                  padding: EdgeInsets.only(top: statusbarHeight + 7, right: 15, left: 15),
                  decoration: const BoxDecoration(
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
                                    color: Colors.grey,
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
                                      color: Colors.grey,
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
          ),
          body: Container(
            color: Colors.green,
            constraints: const BoxConstraints.expand(), // ocupar toda area
            child: Column(
                children: [
                  Container(color: Colors.red,
                      child: const Text('containerrrr')
                  ),
                  Image.asset("images/logo.png"),
                  TextField(),
                  InkWell(
                    splashColor: Colors.red,
                    child: Container(color: Colors.red,
                        child: const Text('containerrrr')
                    ),
                  ),
                  AnimatedContainer(
                    height: sideLength,
                    width: sideLength,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeIn,
                    child: Material(
                      color: Colors.yellow,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            sideLength == 50 ? sideLength = 100 : sideLength = 50;
                          });
                        },
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    height: sideLength,
                    width: sideLength,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeIn,
                    child: Material(
                      color: Colors.red,
                      child: InkWell(
                        onTap: () { },
                      ),
                    ),
                  ),
                ]
            ),
          )
      ),
    );
  }

  InputBorder customedOutlineInputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey)
    );
  }

  Color get primaryColor => Colors.pink.shade400;


}
