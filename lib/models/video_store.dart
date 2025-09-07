import 'video.dart';

class VideoStore {
  static final List<Video> savedVideos = [];

  static void addVideo(Video video) {
    if (!savedVideos.any((v) => v.imageUrl == video.imageUrl)) {
      savedVideos.add(video);
    }
  }

  static List<Video> getSavedVideos() {
    return savedVideos;
  }
} 