class Visitor {
  String visitor_name;
  String visitor_email;
  String visitor_phone_number;
  String visitor_organization;
  String visitor_purpose;
  String visitor_whom_meet;
  final String visit_date;
  final String visit_time;
  int id;
  bool status_visitor;
  String image_filename;
  String image_url;

  Visitor({
    required this.status_visitor,
    required this.id,
    required this.visitor_name,
    required this.visitor_email,
    required this.visitor_phone_number,
    required this.visitor_organization,
    required this.visitor_purpose,
    required this.visitor_whom_meet,
    required this.visit_date,
    required this.visit_time,
    required this.image_filename,
    required this.image_url,
  });

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'visitor_name': visitor_name,
        'visitor_email': visitor_email,
        'visitor_phone_number': visitor_phone_number,
        'visitor_organization': visitor_organization,
        'visitor_purpose': visitor_purpose,
        'visitor_whom_meet': visitor_whom_meet,
        'visit_date': visit_date,
        'visit_time': visit_time,
        'image_filename': image_filename,
        // 'dateSelected':dateSelected,
      };

  factory Visitor.fromJson(Map<dynamic, dynamic> json) {
    return Visitor(
      status_visitor: json['status_visitor'],
      id: json['id'],
      visitor_name: json['visitor_name'],
      visitor_email: json['visitor_email'],
      visit_date: json['visit_date'],
      visitor_organization: json['visitor_organization'],
      visitor_phone_number: json['visitor_phone_number'],
      visitor_purpose: json['visitor_purpose'],
      visit_time: json['visit_time'],
      visitor_whom_meet: json['visitor_whom_meet'],
      image_filename: json['image_filename'],
      image_url: json['image_url'],

      // ... other properties
    );
  }
}
