class LoopData {
  final String imagePath;
  final String loopTitle;
  final String artistName;
  final String artistImagePath;
  final String audioPath;
  final String licensing;
  final int comments;
  final int likes;
  final bool hasBeenOnLeaderboard;
  final String pathToWaveForm;
  final int dislikes;
  final List<String> tags;
  final String location;
  final String topComment;

  LoopData({
    required this.imagePath,
    required this.loopTitle,
    required this.artistName,
    required this.artistImagePath,
    required this.audioPath,
    required this.licensing,
    required this.comments,
    required this.likes,
    required this.hasBeenOnLeaderboard,
    required this.pathToWaveForm,
    required this.dislikes,
    required this.tags,
    required this.location,
    required this.topComment,
  });
}