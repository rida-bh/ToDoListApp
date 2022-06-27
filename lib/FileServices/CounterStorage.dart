import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.db');
  }

  Future<List> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      final contents = await file.readAsString();
      // convert to json code
      //print(contents);
      List<dynamic> result = jsonDecode(contents);
      // return json code
      return result;
    } catch (e) {
      // If encountering an error, return {}
      return [];
    }
  }

  Future<File> writeCounter(var content) async {
    final file = await _localFile;
    String jsonString = jsonEncode(content);
    // Write the file
    return file.writeAsString(jsonString);
  }
}