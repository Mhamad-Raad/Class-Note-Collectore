import 'package:fyp/models/Student.dart';

class Message {
  String Content;
  String Ownerid;
  late String ownerName;
  String MessageId;

  Message({
    required this.Content,
    required this.Ownerid,
    required this.MessageId,
  });
}
