import 'package:flutter/material.dart';
import 'package:sercult/app_config.dart';

PreferredSizeWidget topBar(context){
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
            image: DecorationImage(
                image: AssetImage(AppConfig.pathImageBkgTopbar),
                fit: BoxFit.cover
            ),
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
                            style: TextStyle(color: AppConfig.primaryColor, fontSize: 22, fontWeight: FontWeight.w600)),
                        Image.asset(AppConfig.pathImageLogo)
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
                    onChanged: (text){
                      searchController;
                      // setState(()=> searchController );
                      },
                    decoration: InputDecoration(
                        alignLabelWithHint: true,
                        hintText: 'Eventos, Locais, Centros Culturais...',
                        fillColor: Colors.white, filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                        enabledBorder: _customedOutlineInputBorder(),
                        focusedBorder: _customedOutlineInputBorder(),
                        border: _customedOutlineInputBorder(),
                        prefixIcon: Material(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red.withOpacity(0),
                          child: InkWell(onTap: (){},
                            child: IconButton(
                                splashRadius: 20,
                                color: AppConfig.primaryColor,
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
                                color: AppConfig.primaryColor,
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

InputBorder _customedOutlineInputBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: AppConfig.primaryColor)
  );
}