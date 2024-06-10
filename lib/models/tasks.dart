
class Tasks {
  late int id;
  late String title;
  late String text;
  late String data;
  late int status;
  late String dueto;

  Tasks({
    
    required this.id,
    required this.title,
    required this.text,
    required this.data,
    required this.status,
    required this.dueto,
  });

  factory Tasks.fromMap(Map<String, dynamic> json) => Tasks(
        id: json['id'],
        title: json['title'],
        text: json['text'],
        data: json['data'],
        status: json['status'],
        dueto: json['dueto'],
      );


 
  
  }
  

  
