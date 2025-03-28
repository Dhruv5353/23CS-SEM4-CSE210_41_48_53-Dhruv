import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:the_eduventure/subject_details_page.dart';
import 'package:the_eduventure/all_subjects_page.dart';
import 'auth_service.dart';

class FacultyHome extends StatefulWidget {
  const FacultyHome({super.key});

  @override
  State<FacultyHome> createState() => _FacultyHomeState();
}

class _FacultyHomeState extends State<FacultyHome> {
  int _currentCarouselIndex = 0;
  String _userName = '';
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await _authService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name ?? 'Professor';
      });
    }
  }

  // Dummy data for trending games
  final List<Map<String, dynamic>> _trendingGames = [
    {
      'title': 'DAA Quiz Challenge',
      'description': 'Test your knowledge of algorithms and data structures',
      'image': 'assets/physics_quiz.png',
      'participants': 234,
      'color': const Color(0xFF3498DB),
    },
    {
      'title': 'DAA Puzzle Race',
      'description': 'Solve Coding problems faster than your classmates',
      'image': 'assets/math_puzzle.png',
      'participants': 189,
      'color': const Color(0xFF9B59B6),
    },
    {
      'title': 'Programming Trivia',
      'description': 'Fun questions about coding and computer science',
      'image': 'assets/programming_trivia.png',
      'participants': 156,
      'color': const Color(0xFF2ECC71),
    },
    {
      'title': 'Python Timeline Challenge',
      'description': 'Test your knowledge of Python programming',
      'image': 'assets/history_timeline.png',
      'participants': 122,
      'color': const Color(0xFFE74C3C),
    },
  ];

  // Dummy data for subjects
  final List<Map<String, dynamic>> _subjects = [
    {
      'name': 'DAA',
      'icon': Icons.calculate,
      'color': const Color(0xFF3498DB),
      'games': 12,
      'chapters': 8,
    },
    {
      'name': 'DCN',
      'icon': Icons.science,
      'color': const Color(0xFF2ECC71),
      'games': 8,
      'chapters': 6,
    },
    {
      'name': 'Python',
      'icon': Icons.computer,
      'color': const Color(0xFF9B59B6),
      'games': 15,
      'chapters': 10,
    },
    {
      'name': 'DBMS',
      'icon': Icons.biotech,
      'color': const Color(0xFFE67E22),
      'games': 7,
      'chapters': 7,
    },
    {
      'name': 'SE',
      'icon': Icons.book,
      'color': const Color(0xFFE74C3C),
      'games': 9,
      'chapters': 5,
    },
    {
      'name': 'DSA',
      'icon': Icons.history_edu,
      'color': const Color(0xFF795548),
      'games': 6,
      'chapters': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverAppBar(
              expandedHeight: 120.0,
              floating: true,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, Professor $_userName! 👋',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3748),
                        ),
                      ),
                      Text(
                        'Ready to inspire your students today?',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFF718096),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications_none_rounded, size: 28),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 14,
                            minHeight: 14,
                          ),
                          child: const Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: const Color(0xFF2D3748),
                  onPressed: () {
                    // Add notification functionality
                  },
                ),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'faculty_profile');
                    },
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: const AssetImage(
                        'assets/profile_pic.jpg',
                      ),
                      onBackgroundImageError: (_, __) {},
                    ),
                  ),
                ),
              ],
            ),

            // Body Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha(25), // 0.1 * 255 = 25
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Color(0xFF718096),
                          ),
                          hintText: 'Search for games, subjects...',
                          hintStyle: GoogleFonts.poppins(
                            color: const Color(0xFFA0AEC0),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Trending Games section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Trending Games',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D3748),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to all games screen
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF5A6BF5),
                          ),
                          child: Text(
                            'See All',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // Carousel for trending games
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration: const Duration(
                              milliseconds: 800,
                            ),
                            viewportFraction: 0.8,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentCarouselIndex = index;
                              });
                            },
                          ),
                          items: _trendingGames.map((game) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    // Navigate to game details
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        16.0,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(
                                            0.15,
                                          ),
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        16.0,
                                      ),
                                      child: Stack(
                                        children: [
                                          // Image with fallback
                                          Positioned.fill(
                                            child: Image.asset(
                                              game['image'],
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Container(
                                                  color: game['color'],
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.videogame_asset,
                                                      size: 64,
                                                      color: Colors.white
                                                          .withOpacity(0.6),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          // Gradient overlay
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black
                                                        .withOpacity(0.8),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Game info
                                          Positioned(
                                            bottom: 0,
                                            left: 0,
                                            right: 0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                16.0,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    game['title'],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(
                                                    game['description'],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.white
                                                          .withOpacity(
                                                        0.9,
                                                      ),
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(
                                                    height: 8.0,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.people,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 4.0,
                                                      ),
                                                      Text(
                                                        '${game['participants']} participants',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 12,
                                                          vertical: 6,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(
                                                            0.25,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            20,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Play Now',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _trendingGames.asMap().entries.map((entry) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentCarouselIndex == entry.key
                                    ? const Color(0xFF5A6BF5)
                                    : const Color(0xFFD1D5DB),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24.0),

                    // Subjects section - with animation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Subjects',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D3748),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to all subjects screen
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF5A6BF5),
                          ),
                          child: Text(
                            'See All',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // Grid view for subjects with enhanced design and animation
                    AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 1.4,
                        ),
                        itemCount: _subjects.length,
                        itemBuilder: (context, index) {
                          final subject = _subjects[index];
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            columnCount: 2,
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: GestureDetector(
                                  onTap: () {
                                    // Navigate to subject page
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SubjectDetailsPage(
                                          subject: subject,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withAlpha(
                                            25,
                                          ), // 0.1 * 255 = 25
                                          spreadRadius: 0,
                                          blurRadius: 10,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: subject['color']
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Icon(
                                              subject['icon'],
                                              color: subject['color'],
                                              size: 24,
                                            ),
                                          ),
                                          const SizedBox(height: 12.0),
                                          Text(
                                            subject['name'],
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: const Color(0xFF2D3748),
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Row(
                                            children: [
                                              Text(
                                                '${subject['chapters']} chapters',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: const Color(
                                                    0xFF718096,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 4,
                                                height: 4,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF718096),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                '${subject['games']} games',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: const Color(
                                                    0xFF718096,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 80.0), // Extra space for FAB
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Implement chatbot functionality
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                'AI Study Assistant',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
              content: const Text(
                'The AI chatbot assistant is under development. It will help you with your studies soon!',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.psychology_alt),
        label: Text(
          'Study Assistant',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        backgroundColor: const Color(0xFF5A6BF5),
        elevation: 4,
      ),
    );
  }
}
