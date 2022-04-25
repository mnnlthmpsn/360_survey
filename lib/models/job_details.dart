/// id : 1
/// reg_number : "234E#R$"
/// update_status : "Submitted to commission"
/// status_comments : "Submitted to comission on monday"
/// date : "2014-03-22T00:00:00.000Z"
/// updated_by : "Joe"

class JobDetails {
  JobDetails({
      int? id, 
      String? regNumber, 
      String? updateStatus, 
      String? statusComments, 
      String? date, 
      String? updatedBy,}){
    _id = id;
    _regNumber = regNumber;
    _updateStatus = updateStatus;
    _statusComments = statusComments;
    _date = date;
    _updatedBy = updatedBy;
}

  JobDetails.fromJson(dynamic json) {
    _id = json['id'];
    _regNumber = json['reg_number'];
    _updateStatus = json['update_status'];
    _statusComments = json['status_comments'];
    _date = json['date'];
    _updatedBy = json['updated_by'];
  }
  int? _id;
  String? _regNumber;
  String? _updateStatus;
  String? _statusComments;
  String? _date;
  String? _updatedBy;

  int? get id => _id;
  String? get regNumber => _regNumber;
  String? get updateStatus => _updateStatus;
  String? get statusComments => _statusComments;
  String? get date => _date;
  String? get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reg_number'] = _regNumber;
    map['update_status'] = _updateStatus;
    map['status_comments'] = _statusComments;
    map['date'] = _date;
    map['updated_by'] = _updatedBy;
    return map;
  }

}