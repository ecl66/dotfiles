Vim�UnDo� ֋���F��iu�cH�+⭰�8^K�2�l�  �                 #       #   #   #    ` u    _�                     U       ����                                                                                                                                                                                                                                                                                                                                                             `�     �   T   U            refreshPathologies() async {5�_�                    U       ����                                                                                                                                                                                                                                                                                                                                                             `�     �   T   U              App.currentPathology = 0;5�_�                    U       ����                                                                                                                                                                                                                                                                                                                                                             `�     �   T   U              App.currentPain = 0;5�_�                    U       ����                                                                                                                                                                                                                                                                                                                                                             `�     �   T   U            }5�_�                    U        ����                                                                                                                                                                                                                                                                                                                            U           �           v        `�*     �   T   V  �   �         refreshPraticiens() async {       if (mounted) {         setState(() {           refreshing = true;   	      });       }   #    location = await getLocation();       App.locationError = 1;   ?    if (App.locationError != null && App.me.value['id'] != 0) {   C      var res = await api.getZipcodes(search: App.me.value['zip']);         debug(res.toString());         if (res['ok']) {   @        location.longitude = res['zipcodes'].first['longitude'];   >        location.latitude = res['zipcodes'].first['latitude'];         }       }       // location = res;       )    var res = await api.searchPraticiens(         location.longitude,         location.latitude,   *      search: searchController.text ?? "",         gender: currentGender,         who: App.currentWho,   &      pathology: App.currentPathology,         pain: App.currentPain,   "      practice: currentPracticeId,         zip: currentZip,         when: whenFilters,   1      consultationTypes: consultationTypeFilters,   1      distance: (currentDistance * 1000).toInt(),       );       if (res['ok']) {   .      praticiens = res['praticiens'].toList();   7      // debug("PRATICIENS: " + praticiens.toString());         praticiens   P          .sort((a, b) => (a['distance'] ?? 0) < (b['distance'] ?? 0) ? -1 : 1);         updateMarkers();             if (mounted) {           setState(() {             refreshing = false;           });         }       }     }       $  showPraticienCard(int cabinetId) {   %    App.currentCabinetId = cabinetId;   <    App.navKey.currentState.pushNamed('/praticien_profile');     }         Widget whenSliver() {       return SliverToBoxAdapter(         child: Container(   #        padding: EdgeInsets.all(5),   "        decoration: BoxDecoration(   2          border: Border.all(color: primaryColor),   =          borderRadius: BorderRadius.all(Radius.circular(5)),   
        ),           child: Column(   7          crossAxisAlignment: CrossAxisAlignment.start,             children: [               // Divider(               //   height: 40,               //   thickness: 1,   %            //   color: primaryColor,               // ),               Text(                 'Quand ?',                 style: TextStyle(   $                color: primaryColor,   ,                fontWeight: FontWeight.bold,                 ),               ),               Divider(                 height: 20,   (              color: Colors.transparent,               ),               Wrap(                 children: [                   FilterChip(   .                  label: Text("Dans les 24h"),   .                  selectedColor: primaryColor,   .                  backgroundColor: lightColor,   :                  selected: whenFilters.contains('today'),   ,                  onSelected: (bool value) {   !                    setState(() {   "                      if (value) {   ,                        whenFilters.clear();   1                        whenFilters.add('today');                         } else {   I                        whenFilters.removeWhere((val) => val == 'today');                         }                       });                     },                   ),                   FilterChip(   1                  label: Text("Dans la semaine"),   9                  selected: whenFilters.contains('week'),   .                  selectedColor: primaryColor,   .                  backgroundColor: lightColor,   ,                  onSelected: (bool value) {   !                    setState(() {   "                      if (value) {   ,                        whenFilters.clear();   0                        whenFilters.add('week');                         } else {   H                        whenFilters.removeWhere((val) => val == 'week');                         }                       });                     },                   ),                   FilterChip(   3                  label: Text("Dès que possible"),   9                  selected: whenFilters.contains('asap'),   .                  selectedColor: primaryColor,   .                  backgroundColor: lightColor,   ,                  onSelected: (bool value) {   !                    setState(() {   "                      if (value) {   ,                        whenFilters.clear();   0                        whenFilters.add('asap');                         } else {   H                        whenFilters.removeWhere((val) => val == 'asap');                         }                       });                     },                   ),                 ],               ),             ],   
        ),         ),       );     }       #  Widget consultationTypeSliver() {5�_�                    I        ����                                                                                                                                                                                                                                                                                                                            U           U           v        `�.     �   H   I              await refreshPathologies();5�_�                    I       ����                                                                                                                                                                                                                                                                                                                            T           T           v        `�/     �   H   I          !    // await refreshPraticiens();5�_�      	              H       ����                                                                                                                                                                                                                                                                                                                            S           S           v        `�0     �   G   H              // debug("me: $me");5�_�      
           	   G       ����                                                                                                                                                                                                                                                                                                                            R           R           v        `�2    �   F   G              me = await api.me();5�_�   	              
   Q       ����                                                                                                                                                                                                                                                                                                                            Q          �           v       `�E     �   P   R  T   _   #  Widget consultationTypeSliver() {       return SliverToBoxAdapter(         child: Container(   #        padding: EdgeInsets.all(5),   "        decoration: BoxDecoration(   2          border: Border.all(color: primaryColor),   =          borderRadius: BorderRadius.all(Radius.circular(5)),   
        ),       9        // padding: EdgeInsets.symmetric(horizontal: 10),           child: Column(   7          crossAxisAlignment: CrossAxisAlignment.start,             children: [               // Divider(               //   height: 40,               //   thickness: 1,   %            //   color: primaryColor,               // ),               Text(                 'Où ?',                 style: TextStyle(   $                color: primaryColor,   ,                fontWeight: FontWeight.bold,                 ),               ),               Divider(                 height: 20,   (              color: Colors.transparent,               ),               Wrap(   -              children: App.consultationTypes                     .map(   &                    (t) => FilterChip(   -                      label: Text(t['name']),   2                      selectedColor: primaryColor,   2                      backgroundColor: lightColor,   J                      selected: consultationTypeFilters.contains(t['id']),   0                      onSelected: (bool value) {   %                        setState(() {   &                          if (value) {   ?                            // consultationTypeFilters.clear();   A                            consultationTypeFilters.add(t['id']);   "                          } else {   3                            consultationTypeFilters   F                                .removeWhere((val) => val == t['id']);                             }                           });                         },                       ),                     )                     .toList(),                 // FilterChip(   5              //   label: Text("Téléconsultation"),                 //   selected:   L              //       consultationTypeFilters.contains('teleconsultation'),   /              //   selectedColor: primaryColor,   /              //   backgroundColor: lightColor,   -              //   onSelected: (bool value) {   "              //     setState(() {   #              //       if (value) {   <              //         // consultationTypeFilters.clear();   I              //         consultationTypeFilters.add('teleconsultation');                 //       } else {   0              //         consultationTypeFilters   N              //             .removeWhere((val) => val == 'teleconsultation');                 //       }                 //     });                 //   },                 // ),                 // FilterChip(   -              //   label: Text("A domicile"),   J              //   selected: consultationTypeFilters.contains('domicile'),   /              //   backgroundColor: lightColor,   /              //   selectedColor: primaryColor,   -              //   onSelected: (bool value) {   "              //     setState(() {   #              //       if (value) {   <              //         // consultationTypeFilters.clear();   A              //         consultationTypeFilters.add('domicile');                 //       } else {   0              //         consultationTypeFilters   F              //             .removeWhere((val) => val == 'domicile');                 //       }                 //     });                 //   },                 // ),                 // ],               ),             ],   
        ),         ),       );     }         updateMarkers() {5�_�   
                 Q       ����                                                                                                                                                                                                                                                                                                                            Q          Q          v       `�Q    �   P   R  �      /  Widget consultationTypeSli  updateMarkers() {5�_�                    i       ����                                                                                                                                                                                                                                                                                                                            Q          Q          v       `�`     �   h   i          -                  showPraticienCard(p['id']);5�_�                    �       ����                                                                                                                                                                                                                                                                                                                            Q          Q          v       `��    �   �   �          "              refreshPraticiens();5�_�                    �   
    ����                                                                                                                                                                                                                                                                                                                            Q          Q          v       `��     �   �   �                    refreshPraticiens();5�_�                           ����                                                                                                                                                                                                                                                                                                                                     �           v       `��     �      �   �         Widget whoSelector() {       return Container(         height: 24.0 * 7,   7      // padding: EdgeInsets.symmetric(horizontal: 20),          decoration: BoxDecoration(   /        border: Border.all(color: shadowColor),   ;        borderRadius: BorderRadius.all(Radius.circular(5)),         ),         child: CupertinoPicker(           itemExtent: 32,           diameterRatio: 1.0,           children: [Text("")] +               App.whos                   .map(   )                  (p) => Text(p['name']),                   )                   .toList(),   *        onSelectedItemChanged: (int val) {             setState(() {               if (val > 0) {                  whoFilter.clear();   3              whoFilter.add(App.whos[val]['name']);   3              App.currentWho = App.whos[val]['id'];               } else {                  whoFilter.clear();               }             });             //   if (val == 0) {   6          //     App.currentPainStr = "Choisir parmi";   %          //     App.currentPain = 0;             //   } else {   <          //     App.currentPain = App.pains[val - 1]['id'];   A          //     App.currentPainStr = App.pains[val - 1]['name'];   ;          //     // debug("selected $currentPathologyStr");             //   }   
        },         ),       );       // return App.whos   "    //     .map((w) => FilterChip(   (    //           label: Text(w['name']),   9    //           selected: whoFilter.contains(w['name']),   ,    //           selectedColor: accentColor,   -    //           backgroundColor: lightColor,   )    //           onSelected: (bool val) {        //             setState(() {       //               if (val) {   )    //                 whoFilter.clear();   0    //                 whoFilter.add(w['name']);   0    //                 App.currentWho = w['id'];       //               } else {   )    //                 whoFilter.clear();       //               }       //             });       //           },       //         ))       //     .toList();   &    //                     FilterChip(   ;    //                       label: Text("Pour une femme"),   C    //                       selected: whoFilter.contains('woman'),   9    //                       selectedColor: primaryColor,   5    //                       onSelected: (bool val) {   ,    //                         setState(() {   +    //                           if (val) {   5    //                             whoFilter.clear();   :    //                             whoFilter.add('woman');   )    //                           } else {   5    //                             whoFilter.clear();   "    //                           }   "    //                         });       //                       },       //                     ),   &    //                     FilterChip(   :    //                       label: Text("Pour un homme"),   A    //                       selected: whoFilter.contains('man'),   9    //                       selectedColor: primaryColor,   5    //                       onSelected: (bool val) {   ,    //                         setState(() {   +    //                           if (val) {   5    //                             whoFilter.clear();   8    //                             whoFilter.add('man');   )    //                           } else {   5    //                             whoFilter.clear();   "    //                           }   "    //                         });       //                       },       //                     ),       
    // });     }         Widget forWhoSliver() {       return SliverToBoxAdapter(         child: Container(           // color: accentColor,   9        // padding: EdgeInsets.symmetric(horizontal: 10),   $        padding: EdgeInsets.all(15),   "        decoration: BoxDecoration(   2          border: Border.all(color: primaryColor),   =          borderRadius: BorderRadius.all(Radius.circular(5)),   
        ),               child: Column(   7          crossAxisAlignment: CrossAxisAlignment.start,             children: [   F            // Divider(thickness: 1, height: 40, color: primaryColor),               Text(                 'Pour qui ?',                 style: TextStyle(   $                color: primaryColor,   ,                fontWeight: FontWeight.bold,                 ),               ),               whoSelector(),             ],   
        ),         ),       );     }       $  Widget forWhichPathologySliver() {       return SliverToBoxAdapter(         child: Container(           // color: accentColor,   G        // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),   $        padding: EdgeInsets.all(15),   "        decoration: BoxDecoration(   2          border: Border.all(color: primaryColor),   =          borderRadius: BorderRadius.all(Radius.circular(5)),   
        ),               child: Column(   7          crossAxisAlignment: CrossAxisAlignment.start,             children: [               Text(   &              'Pour quelle maladie ?',                 style: TextStyle(   $                color: primaryColor,   ,                fontWeight: FontWeight.bold,                 ),               ),               Container(                 height: 24.0 * 7,   (              decoration: BoxDecoration(   7                border: Border.all(color: shadowColor),   C                borderRadius: BorderRadius.all(Radius.circular(5)),                 ),   %              child: CupertinoPicker(                   itemExtent: 32,   #                diameterRatio: 1.0,   &                children: [Text("")] +   #                    App.pathologies                           .map(   1                          (p) => Text(p['name']),                           )   "                        .toList(),   2                onSelectedItemChanged: (int val) {   !                  if (val == 0) {   -                    App.currentPathology = 0;   D                    App.currentPathologyStr = "Choisir une maladie";                     } else {   J                    App.currentPathology = App.pathologies[val - 1]['id'];   O                    App.currentPathologyStr = App.pathologies[val - 1]['name'];   2                    // debug(currentPathologyStr);                     }   %                  // setState(() {});                   },                 ),               ),             ],   
        ),         ),       );     }         Widget forWhichPainSliver() {       return SliverToBoxAdapter(         child: Container(           // color: accentColor,   9        // padding: EdgeInsets.symmetric(horizontal: 10),   D        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),   "        decoration: BoxDecoration(   2          border: Border.all(color: primaryColor),   =          borderRadius: BorderRadius.all(Radius.circular(5)),   
        ),           child: Column(   7          crossAxisAlignment: CrossAxisAlignment.start,             children: [               Text(   "              'Pour quels maux ?',                 style: TextStyle(   $                color: primaryColor,   ,                fontWeight: FontWeight.bold,                 ),               ),               Container(                 height: 24.0 * 7,   (              decoration: BoxDecoration(   7                border: Border.all(color: shadowColor),   C                borderRadius: BorderRadius.all(Radius.circular(5)),                 ),   %              child: CupertinoPicker(                   itemExtent: 32,   #                diameterRatio: 1.0,   &                children: [Text("")] +                       App.pains                           .map(   1                          (p) => Text(p['name']),                           )   "                        .toList(),   2                onSelectedItemChanged: (int val) {   !                  if (val == 0) {   9                    App.currentPainStr = "Choisir parmi";   (                    App.currentPain = 0;                     } else {   ?                    App.currentPain = App.pains[val - 1]['id'];   D                    App.currentPainStr = App.pains[val - 1]['name'];   >                    // debug("selected $currentPathologyStr");                     }                   },                 ),               ),             ],   
        ),         ),       );     }       "  List<Widget> assistantSliver() {5�_�                           ����                                                                                                                                                                                                                                                                                                                                                v       `��     �                    forWhoSliver(),5�_�                          ����                                                                                                                                                                                                                                                                                                                                                v       `��     �                     forWhichPathologySliver(),5�_�                          ����                                                                                                                                                                                                                                                                                                                                                v       `��     �                    forWhichPainSliver(),5�_�                          ����                                                                                                                                                                                                                                                                                                                                    R                 `     �    S     >       return [         spacingSliver(),         spacingSliver(),         spacingSliver(),             // // Wrap(   #      // //   children: whoChips(),         // // ),   @      // Divider(thickness: 1, height: 40, color: primaryColor),             // // DropdownButton(         // //   icon: IconButton(   )      // //     icon: Icon(Icons.cancel),         // //     onPressed: () {   '      // //       currentPathology = 0;   >      // //       currentPathologyStr = "Choisir une maladie";   "      // //       setState(() {});         // //     },         // //   ),         // //   hint: Text(   $      // //     currentPathologyStr,   ,      // //     textAlign: TextAlign.center,         // //   ),          // //   items: pathologies         // //       .map(   ,      // //         (p) => DropdownMenuItem(   %      // //           value: p['id'],   -      // //           child: Text(p['name']),   0      // //           onTap: () => setState(() {   7      // //             debug("selected " + p['name']);   3      // //             currentPathology = p['id'];   8      // //             currentPathologyStr = p['name'];         // //           }),         // //         ),         // //       )         // //       .toList(),   (      // //   onChanged: (dynamic res) {   &      // //     debug(res.toString());         // //   },         // // ),   C      // // Divider(thickness: 1, height: 40, color: primaryColor),         // Divider(         //   thickness: 1,         //   height: 40,         //   color: primaryColor,         // ),         SliverToBoxAdapter(           child: Container(   !          width: double.infinity,             child: RaisedButton(   /            child: Text("Lancer la recherche"),               onPressed: () {                 setState(() {   $                showFilters = false;                 });   "              refreshPraticiens();               },             ),   
        ),         ),       ];     }�            "  List<Widget> assistantSliver() {5�_�                   �   	    ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` #    �  �  �        "          practicesSearch == false                 ? Container()                 : Expanded(   "                  child: ListView(   +                    children: App.practices   /                        .where((p) => p['name']   *                            .toLowerCase()   K                            .contains(searchController.text.toLowerCase()))   *                        .map((dynamic z) {   &                      return ListTile(   #                        onTap: () {   <                          searchController.text = z['name'];   6                          currentPracticeId = z['id'];   2                          practicesSearch = false;   *                          setState(() {});                           },   /                        title: Text(z['name']),                         );                        }).toList(),                     ),                   ),   
        ],5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` F     �  �  �              App.selectedPraticien =5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` F     �  �  �          =        praticiens.firstWhere((p) => p['id'] == praticienId);5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` G     �  �  �          ;    App.selectedService = App.selectedPraticien['services']5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` H     �  �  �          1        .firstWhere((s) => s['id'] == serviceId);5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` I    �  �  �          2    App.navKey.currentState.pushNamed('/booking');5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` P    �  �  �          7                    showPraticienCard(praticien['id']);5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` [     �  �  �          "              refreshPraticiens();5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` f     �  �  �          %                        whenSliver(),5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` g     �  �  �          1                        consultationTypeSliver(),5�_�                   �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` i     �  �  �          )                      assistantSliver() +5�_�                    �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` k     �  �  �                                ] +5�_�      !              �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` l     �  �  �                                [5�_�       "           !  �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` r     �  �  �          (                        spacingSliver(),5�_�   !   #           "  �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` s     �  �  �          (                        spacingSliver(),5�_�   "               #  �       ����                                                                                                                                                                                                                                                                                                                           �   	      �          v       ` t    �  �  �          (                        spacingSliver(),5��