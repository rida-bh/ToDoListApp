class Task {
  String title="";
  int id=0;
  static int nbId=0;
  bool Status=false;
  Task (){
    title = title;
    id = nbId++;
    Status =Status;
  }
  Map<String, dynamic> toJson() => {
    'title': title,
    'id': id,
    'Status':Status
  };
}