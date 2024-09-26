
class notesimpnames {
  static final String id = "id";
  static final String uniqueId = "uniqueId";
  static final String pin = "pin";
  static final String title = "title";
  static final String content = "content";
  static final String isArchive = "isArchive";
  static final String attachImage = "attachImage";
  static final String createdTime = "createdTime";
  static final String tablename = "Notes";

  static final List<String> values = [id,isArchive,attachImage, uniqueId, pin, title, content, createdTime];
}
//
class Note {
  final int? id;
  final bool pin;
  final bool isArchive;
  final String title;
  final String uniqueId;
  final String content;
  final String? attachImage;
  final DateTime createdTime;

const  Note(
      {this.id,
      required this.pin,
      required this.isArchive,
      required this.title,
      required this.uniqueId,
      required this.content,
      this.attachImage,
      required this.createdTime,});

  Note copy(
      {int? id,
      bool? pin,
      bool? isArchive,
      String? title,
      String? uniqueId,
      String? content,
        String? attachImage,
      DateTime? createdTime,}) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        isArchive: isArchive ?? this.isArchive,
        title: title ?? this.title,
        content: content ?? this.content,
        attachImage: attachImage ?? "",
        uniqueId: uniqueId ?? this.uniqueId,

        createdTime: createdTime ?? this.createdTime,);
  }


  static Note fromJson(Map<String, Object?> Json) {
    return Note(
        id: Json[notesimpnames.id] as int?,
        pin: Json[notesimpnames.pin] == 1,
        isArchive: Json[notesimpnames.isArchive] == 1,
        title: Json[notesimpnames.title] as String,
        uniqueId: Json[notesimpnames.uniqueId] as String,
        content: Json[notesimpnames.content] as String,
        attachImage: Json[notesimpnames.attachImage] as String,
        createdTime: DateTime.parse(Json[notesimpnames.createdTime] as String),

    );
  }

  Map<String, Object?> toJson() {
    return {
      notesimpnames.id: id,
      notesimpnames.pin: pin ? 1 : 0,
      notesimpnames.isArchive: isArchive ? 1 : 0,
      notesimpnames.title: title,
      notesimpnames.uniqueId: uniqueId,
      notesimpnames.content: content,
      notesimpnames.attachImage: attachImage ?? "",
       notesimpnames.createdTime: createdTime.toIso8601String(),

    };
  }
}



