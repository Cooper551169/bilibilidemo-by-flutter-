import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateCollectionPage extends StatefulWidget {
  const CreateCollectionPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateCollectionPageState createState() => _CreateCollectionPageState();
}

class _CreateCollectionPageState extends State<CreateCollectionPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isPublic = false;
  File? _coverImage;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickCoverImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, maxWidth: 600);
    if (pickedFile != null) {
      setState(() {
        _coverImage = File(pickedFile.path);
      });
    }
  }

  void _showCoverPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    '从相册选择',
                    style: TextStyle(color: Colors.pink, fontSize: 18),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickCoverImage(ImageSource.gallery);
                },
              ),
              Divider(height: 1),
              ListTile(
                title: Center(
                  child: Text(
                    '拍照',
                    style: TextStyle(color: Colors.pink, fontSize: 18),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickCoverImage(ImageSource.camera);
                },
              ),
              Divider(height: 1),
              ListTile(
                title: Center(
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
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
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('创建', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_nameController.text.isNotEmpty) {
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'description': _descriptionController.text,
                  'isPublic': isPublic,
                  'cover': _coverImage?.path,
                });
              }
            },
            child: Text(
              '完成',
              style: TextStyle(
                color:
                    _nameController.text.isEmpty ? Colors.grey : Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('封面', style: TextStyle(fontSize: 16)),
            trailing: Icon(Icons.chevron_right, color: Colors.grey),
            onTap: _showCoverPicker,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            subtitle:
                _coverImage == null
                    ? null
                    : Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _coverImage!,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
          ),
          Divider(height: 1),
          ListTile(
            leading: Text('*名称', style: TextStyle(color: Colors.red[300])),
            title: TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: '名称',
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Divider(height: 1),
          ListTile(
            title: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: '可填写简介',
                border: InputBorder.none,
              ),
              maxLines: 3,
            ),
          ),
          Divider(height: 1),
          SwitchListTile(
            title: Text('公开'),
            value: isPublic,
            onChanged: (bool value) {
              setState(() {
                isPublic = value;
              });
            },
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
