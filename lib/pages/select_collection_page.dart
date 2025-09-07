import 'package:flutter/material.dart';
import '../models/collection.dart';
import 'create_collection_page.dart';

class SelectCollectionPage extends StatefulWidget {
  const SelectCollectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectCollectionPageState createState() => _SelectCollectionPageState();
}

class _SelectCollectionPageState extends State<SelectCollectionPage> {
  List<Collection> collections = [
    Collection(name: '默认收藏夹', description: '129个内容', isPublic: true),
    Collection(name: '学习', description: '14个内容', isPublic: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('选择收藏夹', style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCollectionPage()),
              );
            },
            child: Row(
              children: [
                Icon(Icons.add, color: Colors.black),
                Text('新建收藏夹', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.watch_later_outlined),
                SizedBox(width: 8),
                Text('添加到稍后再看', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              '选择收藏夹',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                return ListTile(
                  title: Text(collection.name),
                  subtitle: Text(collection.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        collection.isPublic ? Icons.public : Icons.lock,
                        color: Colors.grey,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Radio<int>(
                        value: index,
                        groupValue: null,
                        onChanged: (value) {
                          Navigator.pop(context, collection);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
