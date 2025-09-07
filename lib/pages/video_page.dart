import 'package:bilibilidemo/models/video.dart';
import 'package:flutter/material.dart';
import 'create_collection_page.dart';
import '../models/video_store.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final Video video;

  const VideoPage({super.key, required this.video});

  @override
  // ignore: library_private_types_in_public_api
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _videoController;
  int _selectedCollectionIndex = 0;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/video/chen.mp4')
      ..initialize().then((_) {
        _videoController.setVolume(1.0);
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _addToCollection() {
    VideoStore.addVideo(widget.video);
  }

  void _showAddedToFavorites(BuildContext context) {
    _addToCollection();
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.pink[200], size: 32),
                SizedBox(width: 40),
                Text('已加入"默认收藏夹"', style: TextStyle(fontSize: 18)),
                SizedBox(width: 60),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showCollectionSelector(context);
                  },
                  child: Text(
                    '修改文件夹',
                    style: TextStyle(color: Colors.pink[200], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCollectionSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('已添加到稍后再看')));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.grey[700],
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Text('添加到稍后再看', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Divider(height: 1),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '选择收藏夹',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateCollectionPage(),
                        ),
                      );
                    },
                    icon: Icon(Icons.add, color: Colors.black87),
                    label: Text(
                      '新建收藏夹',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('默认收藏夹'),
                      subtitle: Text('132个内容 · 公开'),
                      trailing: Radio<int>(
                        value: 0,
                        groupValue: _selectedCollectionIndex,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedCollectionIndex = value!;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text('学习'),
                      subtitle: Text('14个内容 · 公开'),
                      trailing: Radio<int>(
                        value: 1,
                        groupValue: _selectedCollectionIndex,
                        onChanged: (int? value) {
                          setState(() {
                            _selectedCollectionIndex = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[100],
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    '完成',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage('assets/images/a.jpg'),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '萝卜陈震同学',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '51.9万粉丝',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('+ 关注', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            "【陈浸式出差】北京-北海-北京-巴塞罗那，行程拉满！",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),

          GestureDetector(
            onTap: () {
              _showAddedToFavorites(context);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/icons.jpg',
                width: 600,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedVideo(String title, String views, String imageUrl) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 120,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Text(
                  '$views 观看',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight:
                _videoController.value.isInitialized
                    ? MediaQuery.of(context).size.width /
                        _videoController.value.aspectRatio
                    : MediaQuery.of(context).size.width * 9 / 16,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  _videoController.value.isInitialized
                      ? SizedBox.expand(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: _videoController.value.size.width,
                            height: _videoController.value.size.height,
                            child: VideoPlayer(_videoController),
                          ),
                        ),
                      )
                      : Center(child: CircularProgressIndicator()),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        });
                      },
                      child: Icon(
                        _videoController.value.isPlaying
                            ? Icons.pause_circle_outlined
                            : Icons.play_circle_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      color: Colors.black,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VideoProgressIndicator(
                            _videoController,
                            allowScrubbing: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            colors: VideoProgressColors(
                              playedColor: Colors.pink,
                              bufferedColor: Colors.grey[400]!,
                              backgroundColor: Colors.grey[600]!,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: _videoController,
                                  builder: (
                                    context,
                                    VideoPlayerValue value,
                                    child,
                                  ) {
                                    return Text(
                                      _formatDuration(value.position),
                                      style: TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                                ValueListenableBuilder(
                                  valueListenable: _videoController,
                                  builder: (
                                    context,
                                    VideoPlayerValue value,
                                    child,
                                  ) {
                                    return Text(
                                      _formatDuration(value.duration),
                                      style: TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  _showAddedToFavorites(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.favorite_border, color: Colors.white),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildVideoInfo(context),
                _buildRecommendedVideo(
                  'aespa英文采访,有人只会一句thank u',
                  '12.2万',
                  'assets/images/2a.jpg',
                ),
                _buildRecommendedVideo(
                  '甲亢哥：我登上了中国长城！| Live Speedy',
                  '301.3万',
                  'assets/images/3a.jpg',
                ),
                _buildRecommendedVideo(
                  '梁师傅回应甲亢哥Speed接触的来龙去脉以及网友...',
                  '69.2万',
                  'assets/images/4a.jpg',
                ),
                _buildRecommendedVideo(
                  '人均40元,顺德本地人才知道的绝味餐厅！',
                  '26.4万',
                  'assets/images/5a.jpg',
                ),
                _buildRecommendedVideo(
                  '薛凯琪《苏州河》百万豪装录音棚大声听',
                  '54.9万',
                  'assets/images/6a.jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
