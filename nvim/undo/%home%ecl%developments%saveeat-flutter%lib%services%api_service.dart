Vim�UnDo� >h�:[����7("����)r�;�y�i��[7  �   ?      String name, int quantity, String expirationDate) async {  �   !                       `0    _�                    �       ����                                                                                                                                                                                                                                                                                                                                                             `�     �  �  �  `              'quantity': quantity,5�_�                   �       ����                                                                                                                                                                                                                                                                                                                                                             `�     �  �  �  a              'expiration_date'5�_�                   �   6    ����                                                                                                                                                                                                                                                                                                                                                             `�     �  �  �  a      ?  Future<bool> addIngredient(String name, int quantity) async {5�_�                   �   M    ����                                                                                                                                                                                                                                                                                                                                                             `�'    �   9  �  a  %   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');       return null;     }       9  Future<dynamic> post(String path, dynamic body) async {   D    SharedPreferences prefs = await SharedPreferences.getInstance();   1    String token = prefs.getString("auth_token");       // debug("Token: $token");   �    Http.Response response = await client.post(this.apiEndPoint + path, headers: {"Authorization": token, "Content-Type": "application/json"}, body: body).timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {   )      // debug(response.body.toString());   (      return json.decode(response.body);   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');           return null;     }       8  Future<dynamic> put(String path, dynamic body) async {   D    SharedPreferences prefs = await SharedPreferences.getInstance();   1    String token = prefs.getString("auth_token");       // debug("Token: $token");   �    Http.Response response = await client.put(this.apiEndPoint + path, headers: {"Authorization": token, "Content-Type": "application/json"}, body: body).timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {   )      // debug(response.body.toString());   (      return json.decode(response.body);   
    } else         return null;     }       "  Future<dynamic> logout() async {   D    SharedPreferences prefs = await SharedPreferences.getInstance();   .    await prefs.setString("auth_token", null);   A    await App.navKey.currentState.pushReplacementNamed('/login');     }       /  Future<dynamic> getIngredient(int id) async {   0    dynamic data = await get("/ingredient/$id");   2    return data == null ? [] : data['ingredient'];     }       V  Future<dynamic> getApp({int astuceId = 0, int recipeId = 0, os = "unknown"}) async {       var body = json.encode({         "astuce": astuceId,         "recipe": recipeId,         "os": os,       });   '    return await put("/get_app", body);     }       F  Future<dynamic> updateIngredient(int id, dynamic ingredient) async {   �    var body = json.encode({"place": ingredient['place'], 'quantity': ingredient['quantity'], 'expiration_date': ingredient['expiration_date']});       (    // debug("updating ingredient $id");       // debug(body);       5    return await put("/ingredient/$id/update", body);     }         Future<dynamic> me() async {   7    this.prefs = await SharedPreferences.getInstance();   9    // String token = this.prefs.getString("auth_token");   B    String firebaseId = this.prefs.getString("firebaseId") ?? "0";   %    String os = operatingSystem.name;   I    //Platform.isIOS ? "os" : Platform.isAndroid ? "android" : "unknown";   ;    var res = await get("/me?os=$os&firebase=$firebaseId");       // debug(res);   k    if (res == null || res['success'] == false) await App.navKey.currentState.pushNamed<dynamic>('/login');       return res;     }       B  Future<String> isLoggedIn(String email, String password) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   ,    if (token == null || token.isNotEmpty) {   2      var res = await this.login(email, password);   6      // debug("isLoggedIn got login response: $res");         return res;       }   ,    // debug("isLoggedIn returning $token");       return token;     }       =  Future<String> login(String email, String password) async {   7    this.prefs = await SharedPreferences.getInstance();   	    try {   �      dynamic response = await client.post(this.apiEndPoint + "/authenticate", body: json.encode({'email': email, 'password': password}), headers: {'content-type': 'application/json'}).timeout(   *        Duration(seconds: networkTimeout),           onTimeout: () {             return null;   
        },         );   ;      if (response != null && response.statusCode == 200) {   B        // debug('Login Response status: ${response.statusCode}');   :        // debug('Login Response body: ${response.body}');   .        var data = json.decode(response.body);   '        var token = data['auth_token'];           if (token != null) {   :          await this.prefs.setString("auth_token", token);   B          await App.navKey.currentState.pushReplacementNamed('/');             // return token;   	        }           return null;         }       } finally {}       return null;     }       <  Future<String> facebookLogin(String facebookToken) async {   	    try {   9      this.prefs = await SharedPreferences.getInstance();   y      var response = await this.client.post(this.apiEndPoint + "/authenticate/facebook", body: {'token': facebookToken});   ?      debug('FBLogin Response status: ${response.statusCode}');   7      debug('FBLogin Response body: ${response.body}');   '      if (response.statusCode == 200) {   .        var data = json.decode(response.body);   '        var token = data['auth_token'];           if (token != null) {   5          await prefs.setString("auth_token", token);             return token;   	        }           return null;         }       } finally {}       return null;     }       Y  Future<dynamic> updateUserProfile({String email, String firstname, int gender}) async {   �    return await post('/user/update/profil', jsonEncode({'email': email, 'first_name': firstname, 'gender': gender, 'pseudo': firstname}));     }       8  Future<dynamic> updateNewsletter(bool enabled) async {   P    return await post('/user/setnewsletter', json.encode({'enabled': enabled}));     }       2  Future<dynamic> updateRating(int rating) async {   C    return await post('/user/rate', json.encode({'rate': rating}));     }       4  Future<dynamic> resetPassord(String email) async {   H    return await post('/reset/password', json.encode({'email': email}));     }       d  Future<dynamic> register(String firstname, String email, String password, bool newsletter) async {   �    return await post('/user/new', json.encode({'pseudo': firstname, 'email': email, 'password': password, 'newsletter': newsletter}));     }         Future<Map> searchRecipe({       String text = "",       String page = "0",       String type = "",       String sort = "date",   !    Map<dynamic, dynamic> filter,       List<dynamic> ingredients,       int theme = 0,     }) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");       var response;           var body;           if (theme > 0) {   @      return await get("/recipes/theme_v2/$theme?search=$text");   =      // debug('themeRecipe status: ${response.statusCode}');   8      // // debug('themeRecipe body: ${response.body}');   *      // if (response.statusCode == 200) {   1      //   var data = json.decode(response.body);   /      //   // debug("json:" + data.toString());   ,      //   if (data["ok"] == 1) return data;   
      // }         // return null;       }           if (type == "filter") {   g      body = json.encode({"page": page, "search": text, "type": type, "sort": sort, "filter": filter});   '    } else if (type == 'ingredients') {         body = json.encode({           "page": page,           "search": text,           "type": type,           "sort": sort,   #        "ingredients": ingredients,   	      });       } else {         body = json.encode({           "page": page,           "search": text,           "type": type,           "sort": sort,   #        "ingredients": ingredients,   	      });       }   =    var data = await post("/search/recipe_v2/" + page, body);       8    // debug('searchRecipe status: ' + data.toString());       return data;       7    // // debug('searchRecipe body: ${response.body}');   (    // if (response.statusCode == 200) {   /    //   var data = json.decode(response.body);   -    //   // debug("json:" + data.toString());   *    //   if (data["ok"] == 1) return data;       // }       // return null;     }       )  Future<List<dynamic>> recipes() async {   :    // this.prefs = await SharedPreferences.getInstance();   9    // String token = this.prefs.getString("auth_token");   *    dynamic data = await get("/recipes/");   /    return data == null ? [] : data['recipes'];   6    // debug('recipe status: ${response.statusCode}');   7    // // debug('searchRecipe body: ${response.body}');   (    // if (response.statusCode == 200) {   /    //   var data = json.decode(response.body);   -    //   // debug("json:" + data.toString());        //   // if (data["ok"] == 1)        //   return data["recipes"];       // }       // return [];     }       +  Future<dynamic> getRecipe(int id) async {   :    // this.prefs = await SharedPreferences.getInstance();   9    // String token = this.prefs.getString("auth_token");       debug("getRecipe #: $id");   9    return await get("/recipev2/" + id.toString()) ?? [];   <    // // debug('getRecipe status: ${response.statusCode}');   4    // debug('searchRecipe body: ${response.body}');   (    // if (response.statusCode == 200) {   /    //   var data = json.decode(response.body);   -    //   // debug("json:" + data.toString());   *    //   if (data["ok"] == 1) return data;       // }       // return [];     }       /  Future<dynamic> getFreeRecipe(int id) async {   .    Http.Response response = await client.get(   5      apiEndPoint + "/freerecipev2/" + id.toString(),   4      headers: {"Content-Type": "application/json"},   @    ).timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {         // debug(response.body);   (      return json.decode(response.body);   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');       return null;     }       +  Future<dynamic> getAstuce(int id) async {   .    Http.Response response = await client.get(   /      apiEndPoint + "/astuce/" + id.toString(),   4      headers: {"Content-Type": "application/json"},   @    ).timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {         // debug(response.body);   (      return json.decode(response.body);   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');       return null;     }       E  Future<List<dynamic>> getIngredients({String type = "all"}) async {   :    // this.prefs = await SharedPreferences.getInstance();   9    // String token = this.prefs.getString("auth_token");   5    dynamic data = await get("/ingredients/" + type);       //debug(data.toString());   3    return data == null ? [] : data["ingredients"];   ;    // debug('ingredients status: ${response.statusCode}');   @    //debug('getIngredients ' + data['ingredients'].toString());   (    // if (response.statusCode == 200) {   /    //   var data = json.decode(response.body);   -    //   // debug("json:" + data.toString());        //   // if (data["ok"] == 1)   $    //   return data["ingredients"];       // }       // return [];     }       ?  Future<dynamic> getProductFromBarcode(String barcode) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   )    var response = await this.client.get(   5      this.apiEndPoint + "/product/barcode/$barcode",   (      headers: {"Authorization": token},       );   B    debug('getProductFromBarcode status: ${response.statusCode}');   :    debug('getProductFromBarcode body: ${response.body}');   %    if (response.statusCode == 200) {   ,      var data = json.decode(response.body);         if (data['ok'] == 1) {   "        return data["ingredient"];         } else {   q        return {'id': null, 'name': 'produit inconnu', 'brand': 'inconnu', 'product_quantity': 0, 'quantity': 0};         }       }       return null;     }       @  Future<List<dynamic>> searchIngredients(String search) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   8      this.apiEndPoint + "/search/ingredient/?all=true",   ,      body: json.encode({'search': search}),   L      headers: {"Authorization": token, "content-type": "application/json"},       );   @    // debug('searchIngredientsstatus: ${response.statusCode}');   9    // debug('searchIngredients body: ${response.body}');   %    if (response.statusCode == 200) {   ,      var data = json.decode(response.body);   6      if (data['ok'] == 1) return data["ingredients"];       }       return null;     }       +  Future<List<dynamic>> getThemes() async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   )    var response = await this.client.get(   #      this.apiEndPoint + "/themes",   (      headers: {"Authorization": token},       );   6    debug('getThemes status: ${response.statusCode}');   %    if (response.statusCode == 200) {   ,      var data = json.decode(response.body);   1      if (data['ok'] == 1) return data["themes"];       }       return null;     }       ,  Future<bool> eatIngredient(int id) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   /      this.apiEndPoint + "/ingredient/$id/eat",   L      headers: {"Authorization": token, "content-type": "application/json"},       );   &    return response.statusCode == 200;     }       .  Future<bool> trashIngredient(int id) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   1      this.apiEndPoint + "/ingredient/$id/trash",   L      headers: {"Authorization": token, "content-type": "application/json"},       );   &    return response.statusCode == 200;     }       /  Future<bool> deleteIngredient(int id) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   2      this.apiEndPoint + "/ingredient/$id/delete",   L      headers: {"Authorization": token, "content-type": "application/json"},       );   &    return response.statusCode == 200;     }       W  Future<bool> addIngredient(String name, int quantity, String expiration_date) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   +      this.apiEndPoint + "/ingredient/add",         body: json.encode({           'name': name,           'quantity': quantity,   *        'expiration_date': expiration_date   	      }),         headers: {           "Authorization": token,   +        "content-type": "application/json",         },       );   :    debug("addIngredient status: ${response.statusCode}");   &    return response.statusCode == 200;     }       A  Future<dynamic> addIngredientById(int id, int quantity) async {       return await post(         '/ingredient/add_by_id',         json.encode(   	        {             'id': id,             'quantity': quantity,   
        },         ),       );     }       :  Future<dynamic> deleteShoppingIngredient(int id) async {   X    return await post("/shopping_list/delete_ingredient/$id", json.encode({'id=': id}));     }       7  Future<dynamic> deleteOtherIngredient(int id) async {   E    return await post("/delete/other/$id", json.encode({'id=': id}));     }       <  // Future<dynamic> createShoppingList(String name) async {   ]  //   return await post("/shopping_list/create_shopping_list", json.encode({'name': name}));     // }       )  Future<dynamic> deleteAccount() async {   B    return await post('/user/delete_account_v2', json.encode({}));     }       6  Future<dynamic> createOtherList(String name) async {   @    return await post("/add/list", json.encode({'name': name}));     }       )  Future<dynamic> getOtherLists() async {   3    return await get("/shopping_list/other_lists");     }       @  Future<dynamic> createRecipeShoppingList(int recipeId) async {   X    return await post("/shopping_list/$recipeId/create", json.encode({'id': recipeId}));     }       4  Future<dynamic> deleteShoppingList(int id) async {   Z    return await post("/shopping_list/$id/delete_shopping_list", json.encode({'id': id}));     }       <  // Future<dynamic> deleteOtherShoppingList(int id) async {   F  //   return await post("/delete/list/$id", json.encode({'id': id}));     // }       ,  Future<dynamic> getShoppingLists() async {   (    return await get("/shopping_lists");     }       ,  Future<dynamic> recipeLike(int id) async {   G    return await post("/recipe/$id/like/new", json.encode({'id': id}));     }       +  Future<dynamic> getShoppingData() async {   +    return await get("/shopping_lists/v2");   ?    // debug("getShoppingData status: ${response.statusCode}");   :    // // debug("getShoppingData body: ${response.body}");   (    // if (response.statusCode == 200) {   /    //   var data = json.decode(response.body);   *    //   if (data['ok'] == 1) return data;       // }       // return null;     }       2  Future<dynamic> deleteRecipeList(int id) async {   L    return await post('/shopping_list/$id/delete', json.encode({'id': id}));     }       1  Future<dynamic> deleteOtherList(int id) async {   C    return await post('/delete/list/$id', json.encode({'id': id}));     }       Q  Future<bool> addOtherIngredients(List<dynamic> ingredients, int listId) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   *      this.apiEndPoint + "/add/other/new",   D      body: json.encode({"ingredients": ingredients, "id": listId}),   L      headers: {"Authorization": token, "content-type": "application/json"},       );   :    debug("addIngredient status: ${response.statusCode}");   &    return response.statusCode == 200;     }       X  Future<bool> addShoppingListIngredients(List<dynamic> ingredients, int listId) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   B      this.apiEndPoint + "/shopping_list/$listId/add_ingredients",   D      body: json.encode({"ingredients": ingredients, "id": listId}),   L      headers: {"Authorization": token, "content-type": "application/json"},       );   :    debug("addIngredient status: ${response.statusCode}");   &    return response.statusCode == 200;     }       T  Future<bool> addOtherIngredientsById(List<int> ingredientsIds, int listId) async {   7    this.prefs = await SharedPreferences.getInstance();   6    String token = this.prefs.getString("auth_token");   *    var response = await this.client.post(   0      this.apiEndPoint + "/add/other/new_by_id",   G      body: json.encode({"ingredients": ingredientsIds, "id": listId}),   L      headers: {"Authorization": token, "content-type": "application/json"},       );   :    debug("addIngredient status: ${response.statusCode}");   &    return response.statusCode == 200;     }       ,  /// Add ingredient to shopping list listId   U  Future<dynamic> addIngredientToShoppingList(dynamic ingredient, int listId) async {       return await post(   #      "/shopping_list/$listId/add",         json.encode({   2        'ingredient': ingredient['ingredient_id'],   '        'weight': ingredient['weight'],   	      }),       );     }       K  Future<dynamic> authenticateFB(String token, {String state = ''}) async {       Http.Response response =   �        await client.post(this.apiEndPoint + "/authenticate/facebook", headers: {"Content-Type": "application/json"}, body: json.encode({'token': token, 'tag': state})).timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {   )      // debug(response.body.toString());   ,      var data = json.decode(response.body);   :      if (data['ok'] == 1 && data['auth_token'] != null) {           debug(data.toString());   :        var prefs = await SharedPreferences.getInstance();   @        await prefs.setString("auth_token", data['auth_token']);   <        App.navKey.currentState.pushNamed<dynamic>('/home');         }         return data;   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');       return null;     }       j  Future<dynamic> createAccount(String pseudo, String email, String password, {String state = ''}) async {   )    Http.Response response = await client   �        .post(this.apiEndPoint + "/user/crf/new", headers: {"Content-Type": "application/json"}, body: json.encode({'pseudo': pseudo, 'email': email, 'password': password, 'tag': state}))   C        .timeout(Duration(seconds: networkTimeout), onTimeout: () {   ;      App.navKey.currentState.pushNamed<dynamic>('/login');         return null;       });   9    if (response != null && response.statusCode == 200) {   &      debug(response.body.toString());   ,      var data = json.decode(response.body);         debug(data.toString());         if (data['ok'] == 1) {   <        App.navKey.currentState.pushNamed<dynamic>('/home');         }         return data;   t    } else if (response != null && response.statusCode == 401) App.navKey.currentState.pushNamed<dynamic>('/login');5�_�                   �   3    ����                                                                                                                                                                                                                                                                                                                                                             `��     �  �  �  �      @      String name, int quantity, String expiration_date) async {5�_�                   �   3    ����                                                                                                                                                                                                                                                                                                                                                             `��     �  �  �  �      ?      String name, int quantity, String expirationdate) async {5�_�                   �   '    ����                                                                                                                                                                                                                                                                                                                                                             `��    �  �  �  �      *        'expiration_date': expiration_date5�_�      	             �       ����                                                                                                                                                                                                                                                                                                                                                             `    �  �  �  �              'quantity': quantity,5�_�      
           	  �   !    ����                                                                                                                                                                                                                                                                                                                                                             `      �  �  �  �      ?      String name, int quantity, String expirationDate) async {5�_�   	              
  �   #    ����                                                                                                                                                                                                                                                                                                                                                             `!     �  �  �  �      A      String name, int quantity, {}String expirationDate) async {5�_�   
                �   7    ����                                                                                                                                                                                                                                                                                                                                                             `$    �  �  �  �        Future<bool> addIngredient(   F      String name, int quantity, {String expirationDate=null}) async {�  �  �  �      @      String name, int quantity, {String expirationDate) async {5�_�                    �   #    ����                                                                                                                                                                                                                                                                                                                                                             `/    �  �  �  �      -      {String expirationDate = null}) async {5��