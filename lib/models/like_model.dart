class LikeModel {
  bool? isLiked;
  int? like;
  LikeModel({
    this.isLiked,
    this.like,
  });
  LikeModel.fromSnapshot(Map<String,dynamic> snapshot)
      : isLiked = snapshot['isLiked'],
        like = snapshot['like'];
        
  Map<String, dynamic> toMap() => {
        'isLiked': isLiked,
        'like': like,
      };
}