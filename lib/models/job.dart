/// jobs_id : 1
/// client : "arnolddo"
/// reg_num : "234E#R$"
/// co-ordinates : "34ssww"
/// site_location : "Accra"
/// district : "Ablekuma"
/// description : "This is the desc"
/// entry_date : "2014-04-22T00:00:00.000Z"
/// status : "Pending"

class Job {
  Job({
      int? jobsId, 
      String? client, 
      String? regNum, 
      String? coordinates, 
      String? siteLocation, 
      String? district, 
      String? description, 
      String? entryDate, 
      String? status,}){
    _jobsId = jobsId;
    _client = client;
    _regNum = regNum;
    _coordinates = coordinates;
    _siteLocation = siteLocation;
    _district = district;
    _description = description;
    _entryDate = entryDate;
    _status = status;
}

  Job.fromJson(dynamic json) {
    _jobsId = json['jobs_id'];
    _client = json['client'];
    _regNum = json['reg_num'];
    _coordinates = json['co-ordinates'];
    _siteLocation = json['site_location'];
    _district = json['district'];
    _description = json['description'];
    _entryDate = json['entry_date'];
    _status = json['status'];
  }
  int? _jobsId;
  String? _client;
  String? _regNum;
  String? _coordinates;
  String? _siteLocation;
  String? _district;
  String? _description;
  String? _entryDate;
  String? _status;

  int? get jobsId => _jobsId;
  String? get client => _client;
  String? get regNum => _regNum;
  String? get coordinates => _coordinates;
  String? get siteLocation => _siteLocation;
  String? get district => _district;
  String? get description => _description;
  String? get entryDate => _entryDate;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jobs_id'] = _jobsId;
    map['client'] = _client;
    map['reg_num'] = _regNum;
    map['co-ordinates'] = _coordinates;
    map['site_location'] = _siteLocation;
    map['district'] = _district;
    map['description'] = _description;
    map['entry_date'] = _entryDate;
    map['status'] = _status;
    return map;
  }

}