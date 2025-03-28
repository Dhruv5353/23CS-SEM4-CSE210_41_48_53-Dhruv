// // lib/pages/chapter_page.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class ChapterPage extends StatefulWidget {
//   final Map<String, dynamic> subject;
//   final Map<String, dynamic> chapter;

//   const ChapterPage({super.key, required this.subject, required this.chapter});

//   @override
//   State<ChapterPage> createState() => _ChapterPageState();
// }

// class _ChapterPageState extends State<ChapterPage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   // Generate dummy learning materials
//   List<Map<String, dynamic>> _generateMaterials() {
//     final int materialCount = widget.chapter['materials'] as int;
//     final List<Map<String, dynamic>> materials = [];

//     final List<String> materialTypes = [
//       'PDF Document',
//       'Video Lesson',
//       'Interactive Tutorial',
//       'Presentation',
//       'Audio Lecture',
//       'Article',
//     ];

//     final List<IconData> materialIcons = [
//       Icons.picture_as_pdf,
//       Icons.video_library,
//       Icons.touch_app,
//       Icons.slideshow,
//       Icons.headphones,
//       Icons.article,
//     ];

//     for (int i = 1; i <= materialCount; i++) {
//       final typeIndex = (i - 1) % materialTypes.length;
//       materials.add({
//         'id': i,
//         'title': '${widget.chapter['subtitle']} - ${materialTypes[typeIndex]}',
//         'type': materialTypes[typeIndex],
//         'icon': materialIcons[typeIndex],
//         'duration': '${(i * 5) + 10} min',
//         'isCompleted': i <= (materialCount / 2).ceil(),
//       });
//     }

//     return materials;
//   }

//   // Generate dummy games
//   List<Map<String, dynamic>> _generateGames() {
//     final int gameCount = widget.chapter['games'] as int;
//     final List<Map<String, dynamic>> games = [];

//     final List<String> gameTypes = [
//       'Quiz Challenge',
//       'Matching Game',
//       'Puzzle',
//       'Flashcards',
//       'Word Game',
//       'Simulation',
//     ];

//     final List<IconData> gameIcons = [
//       Icons.quiz,
//       Icons.schema,
//       Icons.extension,
//       Icons.flip,
//       Icons.spellcheck,
//       Icons.science,
//     ];

//     for (int i = 1; i <= gameCount; i++) {
//       final typeIndex = (i - 1) % gameTypes.length;
//       games.add({
//         'id': i,
//         'title': '${widget.chapter['subtitle']} ${gameTypes[typeIndex]}',
//         'type': gameTypes[typeIndex],
//         'icon': gameIcons[typeIndex],
//         'players': (i * 15) + 10,
//         'difficulty': ['Easy', 'Medium', 'Hard'][i % 3],
//         'bestScore': i % 2 == 0 ? '${70 + (i * 3)}%' : null,
//       });
//     }

//     return games;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color subjectColor = widget.subject['color'] as Color;
//     final materials = _generateMaterials();
//     final games = _generateGames();

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       appBar: AppBar(
//         backgroundColor: subjectColor,
//         foregroundColor: Colors.white,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               widget.chapter['title'] as String,
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//               ),
//             ),
//             Text(
//               widget.chapter['subtitle'] as String,
//               style: GoogleFonts.poppins(
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           indicatorWeight: 3,
//           labelStyle: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             fontSize: 14,
//           ),
//           tabs: const [
//             Tab(icon: Icon(Icons.book), text: 'Learning Materials'),
//             Tab(icon: Icon(Icons.videogame_asset), text: 'Games'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Learning Materials Tab
//           AnimationLimiter(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: materials.length,
//               itemBuilder: (context, index) {
//                 final material = materials[index];
//                 return AnimationConfiguration.staggeredList(
//                   position: index,
//                   duration: const Duration(milliseconds: 375),
//                   child: SlideAnimation(
//                     verticalOffset: 50.0,
//                     child: FadeInAnimation(
//                       child: _buildMaterialCard(material, subjectColor),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),

//           // Games Tab
//           AnimationLimiter(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: games.length,
//               itemBuilder: (context, index) {
//                 final game = games[index];
//                 return AnimationConfiguration.staggeredList(
//                   position: index,
//                   duration: const Duration(milliseconds: 375),
//                   child: SlideAnimation(
//                     verticalOffset: 50.0,
//                     child: FadeInAnimation(
//                       child: _buildGameCard(game, subjectColor),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       // Floating Action Button to continue learning
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           // Action for continuing from last position
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 'Continuing from where you left off',
//                 style: GoogleFonts.poppins(),
//               ),
//               backgroundColor: subjectColor,
//               behavior: SnackBarBehavior.floating,
//             ),
//           );
//         },
//         icon: const Icon(Icons.play_arrow),
//         label: Text(
//           'Continue Learning',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
//         ),
//         backgroundColor: subjectColor,
//       ),
//     );
//   }

//   Widget _buildMaterialCard(Map<String, dynamic> material, Color color) {
//     return Card(
//       elevation: 0,
//       margin: const EdgeInsets.only(bottom: 12),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         side: BorderSide(
//           color:
//               material['isCompleted']
//                   ? color.withOpacity(0.3)
//                   : Colors.transparent,
//           width: 1,
//         ),
//       ),
//       child: ListTile(
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 12,
//         ),
//         leading: Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(material['icon'] as IconData, color: color),
//         ),
//         title: Text(
//           material['title'] as String,
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
//         ),
//         subtitle: Padding(
//           padding: const EdgeInsets.only(top: 4),
//           child: Row(
//             children: [
//               Icon(Icons.access_time, size: 14, color: const Color(0xFF718096)),
//               const SizedBox(width: 4),
//               Text(
//                 material['duration'] as String,
//                 style: GoogleFonts.poppins(
//                   fontSize: 12,
//                   color: const Color(0xFF718096),
//                 ),
//               ),
//               const SizedBox(width: 16),
//               if (material['isCompleted'])
//                 Row(
//                   children: [
//                     Icon(Icons.check_circle, size: 14, color: color),
//                     const SizedBox(width: 4),
//                     Text(
//                       'Completed',
//                       style: GoogleFonts.poppins(
//                         fontSize: 12,
//                         color: color,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//             ],
//           ),
//         ),
//         trailing: IconButton(
//           icon: Icon(
//             material['isCompleted'] ? Icons.refresh : Icons.play_circle_outline,
//             color: color,
//           ),
//           onPressed: () {
//             // Open or restart the material
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   material['isCompleted']
//                       ? 'Reviewing ${material['title']}'
//                       : 'Starting ${material['title']}',
//                   style: GoogleFonts.poppins(),
//                 ),
//                 behavior: SnackBarBehavior.floating,
//               ),
//             );
//           },
//         ),
//         onTap: () {
//           // Open the material
//         },
//       ),
//     );
//   }

//   Widget _buildGameCard(Map<String, dynamic> game, Color color) {
//     return GestureDetector(
//       onTap: () {
//         // Start the game
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               'Starting ${game['title']}',
//               style: GoogleFonts.poppins(),
//             ),
//             behavior: SnackBarBehavior.floating,
//           ),
//         );
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: color.withOpacity(0.2),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               // Game icon
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   game['icon'] as IconData,
//                   color: Colors.white,
//                   size: 28,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Game details
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       game['title'] as String,
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     // Stats row
//                     Row(
//                       children: [
//                         Icon(
//                           Icons.people,
//                           size: 14,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           '${game['players']} players',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: Colors.white.withOpacity(0.9),
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                             vertical: 2,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             game['difficulty'] as String,
//                             style: GoogleFonts.poppins(
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),

//                     // Best score if available
//                     if (game['bestScore'] != null) ...[
//                       const SizedBox(height: 8),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.3),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(
//                               Icons.emoji_events,
//                               size: 14,
//                               color: Colors.white,
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               'Best: ${game['bestScore']}',
//                               style: GoogleFonts.poppins(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//               // Play button
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(Icons.play_arrow, color: color, size: 28),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ChapterPage extends StatefulWidget {
  final Map<String, dynamic> subject;
  final Map<String, dynamic> chapter;

  const ChapterPage({super.key, required this.subject, required this.chapter});

  @override
  State<ChapterPage> createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Generate dummy learning materials
  List<Map<String, dynamic>> _generateMaterials() {
    final int materialCount = widget.chapter['materials'] as int;
    final List<Map<String, dynamic>> materials = [];

    final List<String> materialTypes = [
      'PDF Document',
      'Video Lesson',
      'Interactive Tutorial',
      'Presentation',
      'Audio Lecture',
      'Article',
    ];

    final List<IconData> materialIcons = [
      Icons.picture_as_pdf,
      Icons.video_library,
      Icons.touch_app,
      Icons.slideshow,
      Icons.headphones,
      Icons.article,
    ];

    for (int i = 1; i <= materialCount; i++) {
      final typeIndex = (i - 1) % materialTypes.length;
      materials.add({
        'id': i,
        'title': '${widget.chapter['subtitle']} - ${materialTypes[typeIndex]}',
        'type': materialTypes[typeIndex],
        'icon': materialIcons[typeIndex],
        'duration': '${(i * 5) + 10} min',
        'isCompleted': i <= (materialCount / 2).ceil(),
      });
    }

    return materials;
  }

  // Generate dummy games
  List<Map<String, dynamic>> _generateGames() {
    final int gameCount = widget.chapter['games'] as int;
    final List<Map<String, dynamic>> games = [];

    final List<String> gameTypes = [
      'Quiz Challenge',
      'Matching Game',
      'Puzzle',
      'Flashcards',
      'Word Game',
      'Simulation',
    ];

    final List<IconData> gameIcons = [
      Icons.quiz,
      Icons.schema,
      Icons.extension,
      Icons.flip,
      Icons.spellcheck,
      Icons.science,
    ];

    for (int i = 1; i <= gameCount; i++) {
      final typeIndex = (i - 1) % gameTypes.length;
      games.add({
        'id': i,
        'title': '${widget.chapter['subtitle']} ${gameTypes[typeIndex]}',
        'type': gameTypes[typeIndex],
        'icon': gameIcons[typeIndex],
        'players': (i * 15) + 10,
        'difficulty': ['Easy', 'Medium', 'Hard'][i % 3],
        'bestScore': i % 2 == 0 ? '${70 + (i * 3)}%' : null,
      });
    }

    return games;
  }

  @override
  Widget build(BuildContext context) {
    final Color subjectColor = widget.subject['color'] as Color;
    final materials = _generateMaterials();
    final games = _generateGames();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: subjectColor,
        foregroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chapter['title'] as String,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              widget.chapter['subtitle'] as String,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.book), text: 'Learning Material'),
            Tab(icon: Icon(Icons.videogame_asset), text: 'Activities'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Learning Materials Tab
          AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: materials.length,
              itemBuilder: (context, index) {
                final material = materials[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildMaterialCard(material, subjectColor),
                    ),
                  ),
                );
              },
            ),
          ),

          // Games Tab
          AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: games.length,
              itemBuilder: (context, index) {
                final game = games[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildGameCard(game, subjectColor),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // Floating Action Button to continue learning
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action for continuing from last position
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Continuing from where you left off',
                style: GoogleFonts.poppins(),
              ),
              backgroundColor: subjectColor,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        icon: const Icon(Icons.play_arrow),
        label: Text(
          'Continue Learning',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        backgroundColor: subjectColor,
      ),
    );
  }

  Widget _buildMaterialCard(Map<String, dynamic> material, Color color) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              material['isCompleted']
                  ? color.withAlpha(77) // 0.3 * 255 = 77
                  : Colors.transparent,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(25), // 0.1 * 255 = 25
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(material['icon'] as IconData, color: color),
        ),
        title: Text(
          material['title'] as String,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Row(
            children: [
              Icon(Icons.access_time, size: 14, color: const Color(0xFF718096)),
              const SizedBox(width: 4),
              Text(
                material['duration'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color(0xFF718096),
                ),
              ),
              const SizedBox(width: 16),
              if (material['isCompleted'])
                Row(
                  children: [
                    Icon(Icons.check_circle, size: 14, color: color),
                    const SizedBox(width: 4),
                    Text(
                      'Completed',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            material['isCompleted'] ? Icons.refresh : Icons.play_circle_outline,
            color: color,
          ),
          onPressed: () {
            // Open or restart the material
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  material['isCompleted']
                      ? 'Reviewing ${material['title']}'
                      : 'Starting ${material['title']}',
                  style: GoogleFonts.poppins(),
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        onTap: () {
          // Open the material
        },
      ),
    );
  }

  Widget _buildGameCard(Map<String, dynamic> game, Color color) {
    return GestureDetector(
      onTap: () {
        // Start the game
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Starting ${game['title']}',
              style: GoogleFonts.poppins(),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withAlpha(204),
              color.withAlpha(153),
            ], // 0.8 * 255 = 204, 0.6 * 255 = 153
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(51), // 0.2 * 255 = 51
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Game icon
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  game['icon'] as IconData,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Game details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game['title'] as String,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Stats row
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 14,
                          color: Colors.white.withAlpha(230), // 0.9 * 255 = 230
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${game['players']} players',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white.withAlpha(
                              230,
                            ), // 0.9 * 255 = 230
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(51), // 0.2 * 255 = 51
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            game['difficulty'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Best score if available
                    if (game['bestScore'] != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(77), // 0.3 * 255 = 77
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.emoji_events,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Best: ${game['bestScore']}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Play button
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.play_arrow, color: color, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
