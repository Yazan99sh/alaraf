class CallModel {
  final String id;
  final int expertId;
  final int userId;
  final String channelId;
  final String userName;
  final String userPicture;
  bool isActive = false;
  String firebaseId;

  CallModel(
      {this.userName, this.userPicture, this.id, this.expertId, this.userId, this.channelId, this.isActive,this.firebaseId});

  toMap() => {
        'id': this.id ?? DateTime.now().toIso8601String(),
        'expertId': this.expertId,
        'channelId': this.channelId,
        'isActive': this.isActive,
        'userId':this.userId,
        'userName':this.userName,
        'userPicture':this.userPicture,
        'date':DateTime.now()
      };

  factory CallModel.fromJson(Map map) => CallModel(
      id: map['id'],
      channelId: map['channelId'],
      isActive: map['isActive'],
      expertId: map['expertId'],
      userId: map['userId'],
      userName: map['userName'],
      userPicture: map['userPicture'],

  );

  @override
  String toString() {
    return 'CallModel{id: $id, expertId: $expertId, userId: $userId, channelId: $channelId, isActive: $isActive}';
  }
}
