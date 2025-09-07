import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'pages/profile_page.dart';
import 'pages/video_page.dart';
import 'pages/search_page.dart';
import 'pages/collections_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'models/video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '哔哩哔哩',
      theme: ThemeData(
        primaryColor: Color(0xFFFF6699),
        scaffoldBackgroundColor: Color(0xFFF4F4F4),
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    Center(child: Text('动态页面')),
    Center(child: Text('发布页面')),
    const CollectionsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black)],
        ),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, LineIcons.home, '首页'),
                _buildNavItem(1, FontAwesomeIcons.wind, '动态'),
                _buildNavItem(2, Icons.add_circle_outline, ''),
                _buildNavItem(3, Icons.shopping_cart_outlined, '会员购'),
                _buildNavItem(4, LineIcons.television, '我的'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedIndex == index;

    if (index == 2) {
      return GestureDetector(
        onTap: () => setState(() => _selectedIndex = index),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 246, 117, 160),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(Icons.add, color: Colors.white, size: 24),
        ),
      );
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? Colors.pink : Colors.grey, size: 24),
            if (label.isNotEmpty) ...[
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.pink : Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  static final List<String> _carouselImages = [
    'assets/images/7.jpg',
    'assets/images/8.jpg',
    'assets/images/9.jpg',
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            floating: true,
            snap: true,
            leading: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/a.jpg'),
              ),
            ),
            title: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchPage()),
                  );
                },
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Icon(Icons.search, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '康康道歉',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Stack(
                  children: [
                    Icon(LineIcons.gamepad, color: Colors.black),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.mail_outline, color: Colors.black),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTab('直播', isSelected: false),
                      _buildTab('推荐', isSelected: true),
                      _buildTab('热门', isSelected: false),
                      _buildTab('追番', isSelected: false),
                      _buildTab('影视', isSelected: false),
                      _buildTab('新征程', isSelected: false),
                      Icon(Icons.notes),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  height: 220,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            _carouselImages[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: _carouselImages.length,
                    autoplay: true,
                    autoplayDelay: 3000,
                    duration: 800,
                    scale: 0.9,
                    viewportFraction: 0.85,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: Color.fromARGB(255, 239, 80, 133),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  padding: EdgeInsets.all(7),
                  childAspectRatio: 0.8,
                  children: [
                    _buildVideoCard(context, 'assets/images/1.jpg'),
                    _buildVideoCard(context, 'assets/images/2.jpg'),
                    _buildVideoCard(context, 'assets/images/3.jpg'),
                    _buildVideoCard(context, 'assets/images/4.jpg'),
                    _buildVideoCard(context, 'assets/images/5.jpg'),
                    _buildVideoCard(context, 'assets/images/6.jpg'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, {required bool isSelected}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.pink : Colors.black,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            Container(
              margin: EdgeInsets.only(top: 4),
              width: 20,
              height: 2,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoCard(BuildContext context, String imageUrl) {
    final video = Video(title: '', author: '', fans: '', imageUrl: imageUrl);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => VideoPage(
                  video: Video(
                    title: '',
                    author: '',
                    imageUrl: imageUrl,
                    fans: '',
                  ),
                ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(Icons.error_outline, color: Colors.grey),
                    ),
                  );
                },
              ),
              Positioned(
                left: 8,
                right: 8,
                bottom: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      video.author,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        shadows: [
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 3.0,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
