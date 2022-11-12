import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:crypto/crypto.dart';

class Digimon {
  final String name;
  String imageUrl;
  String description;

  int rating = 10;

  String apiname;

  String publicKey = "19ba4a7890f2e64e47ca37bb0c913da7";
  String privateKey = "cb1e53d5b1c55100024c867a476d16b2b94e199d";
  int ts;

  Digimon(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = new HttpClient();
    try {
      apiname = name.toLowerCase();
      ts = new DateTime.now().millisecondsSinceEpoch;

      var bits = utf8.encode(ts.toString() + privateKey + publicKey);
      var hash = md5.convert(bits);

      print(ts.toString());
      print(hash.toString());

      var uri = Uri.parse('https://gateway.marvel.com' +
          '/v1/public/characters?name=' +
          apiname +
          '&ts=' +
          DateTime.now().millisecondsSinceEpoch.toString() +
          '&apikey=' +
          publicKey +
          '&hash=' +
          md5
              .convert(utf8.encode(
                  DateTime.now().millisecondsSinceEpoch.toString().toString() +
                      privateKey +
                      publicKey))
              .toString());

      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      List data = json.decode(responseBody)["data"]["results"];
      imageUrl = data[0]["thumbnail"]["path"] + ".jpg";
      description = data[0]["description"];

      print(description);
    } catch (exception) {
      print(exception);
    }
  }
}
