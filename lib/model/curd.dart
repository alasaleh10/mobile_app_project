import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

class curd{

  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error catch $e');
    }
  }


  postRequst(String uri, Map data) async {
    try {
      var response = await http.post(Uri.parse(uri), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);

        return responsebody;
      } else {
        print('Error ${response.statusCode}');
      }
    } catch (e) {
      print('Error catch $e');
    }
  }



  PostwithFile(String uri, Map data, File file) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(uri));

      var length = await file.length();
      var stream = http.ByteStream(file.openRead());

      var muiltpartfile = http.MultipartFile("file", stream, length,
          filename: basename(file.path));
      request.files.add(muiltpartfile);
      data.forEach((key, value) {
        request.fields[key] = value;
      });
      var myrequest = await request.send();

      var response = await http.Response.fromStream(myrequest);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error ${myrequest.statusCode}');
      }
    } catch (e) {
      print('Error is $e');
    }
  }
}