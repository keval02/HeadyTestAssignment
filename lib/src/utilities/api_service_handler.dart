import 'dart:async';

import 'package:http/http.dart' as http;

Future callGetMethod(String url) async {
  return await http.get(Uri.encodeFull(url)).then((http.Response response) {
    return response.body;
  });
}
