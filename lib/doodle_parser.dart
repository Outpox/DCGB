import 'package:http/http.dart' as http;
import 'package:dson/dson.dart';
import 'doodle_response.dart';

var baseUrl = 'https://doodle.com/api/v2.0/polls/';
var pollId = 'c6a4bi6inz4dmypa';

getHtml() {
  http.get(baseUrl + pollId).then((response) {
    // print(response.body);
    //  _initMirrors();
    DoodleResponse dr = fromJson(response.body, DoodleResponse);
    // print(dr.latestChange);
  });
}
