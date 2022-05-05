import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:survey/models/job.dart';
import 'package:survey/models/job_details.dart';
import 'package:survey/utils/strings.dart';

class Repo {
  final Map<String, String> headers = {
    "Content-Type": "application/json;charset=UTF-8"
  };

  Future<dynamic> reqLogin(dynamic params) async {
    try {
      Uri url = Uri.parse('${AppStrings.API_URL}/log_in');
      dynamic res =
          await http.post(url, headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);

      return resBody['status'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> reqRegister(dynamic params) async {
    try {
      Uri url = Uri.parse('${AppStrings.API_URL}/signup');
      dynamic res =
          await http.post(url, headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);
      print(resBody);
      return resBody;
    } catch (e) {

      rethrow;
    }
  }

  Future<bool> validateOTP(dynamic params) async {
    try {
      Uri url = Uri.parse('${AppStrings.API_URL}/Validate_code');
      dynamic res =
          await http.post(url, headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);
      print(resBody);

      return resBody['status'] == 0 ? true : false;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> resendOTP(dynamic params) async {
    print(params);
    try {
      Uri url = Uri.parse('${AppStrings.API_URL}/resend_validation');
      dynamic res =
          await http.post(url, headers: headers, body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);
      print(resBody);


      return resBody['status'] == 0 ? true : false;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Job>> reqJobs(username) async {
    dynamic params = {"username": username, "key": "1qaz@WSX"};

    try {
      dynamic res = await http.post(
          Uri.parse('${AppStrings.API_URL}/user_job_info'),
          headers: headers,
          body: jsonEncode(params));
      dynamic resBody = jsonDecode(res.body);

      if (resBody['status'] == 0) {
        return (resBody['output'] as List)
            .map((temp) => Job.fromJson(temp))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<JobDetails>> reqJobDetails(String username, String regNum) async {
    try {
      dynamic body = {
        "username": username,
        "reg_num": regNum,
        "key": "1qaz@WSX"
      };

      dynamic res = await http.post(
          Uri.parse('${AppStrings.API_URL}/job_status'),
          headers: headers,
          body: jsonEncode(body));
      dynamic resBody = jsonDecode(res.body);
      return (resBody['output'] as List)
          .map((temp) => JobDetails.fromJson(temp))
          .toList();
    } catch (e) {
      rethrow;
    }
  }
}
