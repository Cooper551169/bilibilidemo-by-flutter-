import 'package:flutter/material.dart';
import '../models/collection.dart';
import 'create_collection_page.dart';
import '../models/video_store.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CollectionsPageState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  List<Collection> collections = [];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildVideoList() {
    final savedVideos = VideoStore.getSavedVideos();
    if (savedVideos.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('暂无收藏视频', style: TextStyle(color: Colors.grey)),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: savedVideos.length,
      itemBuilder: (context, index) {
        final video = savedVideos[index];
        return Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  video.imageUrl,
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
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '已收藏',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收藏夹'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '收藏的视频',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildVideoList(),
            Divider(height: 24),
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '收藏夹',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            collections.isEmpty
                ? Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('暂无收藏夹', style: TextStyle(color: Colors.grey)),
                  ),
                )
                : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    final collection = collections[index];
                    return ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child:
                            collection.coverImage != null
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    collection.coverImage!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                : Icon(Icons.folder, color: Colors.grey),
                      ),
                      title: Text(collection.name),
                      subtitle: Text(collection.description),
                      trailing: Icon(
                        collection.isPublic ? Icons.public : Icons.lock,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToCreateCollection,
        backgroundColor: Colors.pink[200],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToCreateCollection() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CreateCollectionPage(),
        fullscreenDialog: true,
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        collections.add(
          Collection(
            name: result['name'],
            description: result['description'],
            isPublic: result['isPublic'],
          ),
        );
      });
    }
  }
}
