import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:survey/models/job.dart';
import 'package:survey/utils/strings.dart';

class Repo {
  final Map<String, String> headers = {
    "Content-Type": "application/json;charset=UTF-8"
  };

  Future<bool> reqLogin(dynamic params) async {
    try {
      Uri url = Uri.parse('${AppStrings.API_URL}/log_in');
      dynamic res = await http.post(url, headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);

      return resBody['status'] == 0 ? true : false;
    } catch(e) {
      rethrow;
    }
  }

  Future<List<Job>> reqJobs(username) async {

    dynamic params = {
      "username": username,
      "key": "1qaz@WSX"
    };

    try {
      dynamic res =
          await http.post(Uri.parse('${AppStrings.API_URL}/user_job_info'), headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);

      return (resBody['output'] as List).map((temp) => Job.fromJson(temp)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
