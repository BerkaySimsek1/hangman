import 'package:dio/dio.dart';

class ApiControl {
  Dio dio = Dio();

  Future<String> fetchWord() async {
    Response response =
        await dio.get("https://api.api-ninjas.com/v1/randomword");
    try {
      if (response.statusCode == 200) {
        return response.data["word"];
      }
    } catch (err) {
      return err.toString();
    }
    return response.statusCode.toString();
  }
}
