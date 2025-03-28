import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'all_subjects_page.dart';
import 'subject_details_page.dart';
import 'auth_service.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
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
        _userName = name ?? 'Student';
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

  // Updated subjects with appropriate icons and proper names for mobile display
  final List<Map<String, dynamic>> _subjects = [
    {
      'name': 'DAA',
      'fullName': 'Design & Analysis of Algorithms',
      'shortName': 'Design & Analysis of Algorithms',
      'icon': Icons.schema, // Algorithm flowchart icon
      'color': const Color(0xFF3498DB),
      'games': 12,
      'chapters': 8,
    },
    {
      'name': 'DCN',
      'fullName': 'Data Communication & Networks',
      'shortName': 'Data Communication & Networks',
      'icon': Icons.router, // Network router icon
      'color': const Color(0xFF2ECC71),
      'games': 8,
      'chapters': 6,
    },
    {
      'name': 'Python',
      'fullName': 'Python Programming',
      'shortName': 'Python Programming',
      'icon': Icons.code, // Code icon for programming
      'color': const Color(0xFF9B59B6),
      'games': 15,
      'chapters': 10,
    },
    {
      'name': 'DBMS',
      'fullName': 'Database Management Systems',
      'shortName': 'Database Management',
      'icon': Icons.storage, // Database storage icon
      'color': const Color(0xFFE67E22),
      'games': 7,
      'chapters': 7,
    },
    {
      'name': 'SE',
      'fullName': 'Software Engineering',
      'shortName': 'Software Engineering',
      'icon': Icons.engineering, // Engineering icon
      'color': const Color(0xFFE74C3C),
      'games': 9,
      'chapters': 5,
    },
    {
      'name': 'DSA',
      'fullName': 'Data Structures & Algorithms',
      'shortName': 'Data Structures & Algorithms',
      'icon': Icons.account_tree, // Tree structure icon
      'color': const Color(0xFF795548),
      'games': 6,
      'chapters': 8,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust layout for different devices
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360; // Adjust based on testing

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Enhanced App Bar
            SliverAppBar(
              expandedHeight: 135.0,
              floating: true,
              pinned: true,
              backgroundColor: Colors.white,
              elevation: 2,
              shadowColor: Colors.black.withOpacity(0.1),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, $_userName! 👋',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF2D3748),
                        ),
                      ),
                      Text(
                        'Ready to learn something new today?',
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
                      Navigator.pushNamed(context, 'student_profile');
                    },
                    child: Hero(
                      tag: 'profile_picture',
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
                    // Enhanced Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
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
                        Row(
                          children: [
                            const Icon(
                              Icons.trending_up,
                              color: Color(0xFF5A6BF5),
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Trending Games',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D3748),
                              ),
                            ),
                          ],
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
                    const SizedBox(height: 14.0),

                    // Enhanced Carousel for trending games
                    Column(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 230.0,
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
                                  child: Hero(
                                    tag: 'game_${game['title']}',
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
                                              bottom: 16,
                                              left: 0,
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  10.0,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      game['title'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 14.0,
                                                    ),
                                                    Text(
                                                      game['description'],
                                                      style:
                                                          GoogleFonts.poppins(
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
                                                      height: 10.0,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.people,
                                                          color: Colors.white,
                                                          size: 16,
                                                        ),
                                                        const SizedBox(
                                                          width: 6.0,
                                                        ),
                                                        Text(
                                                          '${game['participants']} participants',
                                                          style: GoogleFonts
                                                              .poppins(
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
                                                          child: Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .play_arrow_rounded,
                                                                color: Colors
                                                                    .white,
                                                                size: 16,
                                                              ),
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                'Play Now',
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
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
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: _currentCarouselIndex == entry.key
                                  ? 16.0
                                  : 8.0,
                              height: 8.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: _currentCarouselIndex == entry.key
                                    ? const Color(0xFF5A6BF5)
                                    : const Color(0xFFD1D5DB),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28.0),

                    // Subjects section header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.school,
                              color: Color(0xFF5A6BF5),
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'My Subjects',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2D3748),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AllSubjectsPage(subjects: _subjects),
                              ),
                            );
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
                    const SizedBox(height: 16.0),

                    // FIXED SUBJECT GRID: With proper mobile layout
                    AnimationLimiter(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio:
                              1.1, // Adjusted for better mobile layout
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
                                  child: Hero(
                                    tag: 'subject_${subject['name']}',
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 0,
                                            blurRadius: 10,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        child: Stack(
                                          children: [
                                            // Fixed background icon positioning
                                            Positioned(
                                              right: -10,
                                              bottom: -10,
                                              width: 90,
                                              height: 90,
                                              child: Opacity(
                                                opacity: 0.18,
                                                child: Icon(
                                                  subject['icon'],
                                                  size: 70,
                                                  color: subject['color'],
                                                ),
                                              ),
                                            ),

                                            // Content
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // Subject initials with colored background
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                    decoration: BoxDecoration(
                                                      color: subject['color'],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Text(
                                                      subject['name'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8.0),
                                                  // Full subject name - shortened for mobile
                                                  Text(
                                                    subject['shortName'],
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: const Color(
                                                          0xFF2D3748),
                                                    ),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Spacer(),
                                                  // Subject stats with improved layout
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.book_outlined,
                                                        size: 12,
                                                        color: subject['color'],
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${subject['chapters']} chapters',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: const Color(
                                                              0xFF718096),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .videogame_asset_outlined,
                                                        size: 12,
                                                        color: subject['color'],
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        '${subject['games']} games',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          color: const Color(
                                                              0xFF718096),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
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
              title: Row(
                children: [
                  const Icon(
                    Icons.psychology_alt,
                    color: Color(0xFF5A6BF5),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI Study Assistant',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ],
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
