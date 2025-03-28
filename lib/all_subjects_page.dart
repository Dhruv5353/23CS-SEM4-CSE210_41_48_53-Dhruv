// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'subject_details_page.dart';

// class AllSubjectsPage extends StatelessWidget {
//   final List<Map<String, dynamic>> subjects;

//   const AllSubjectsPage({super.key, required this.subjects});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Subjects'),
//         backgroundColor: const Color(0xFF5A6BF5),
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(16.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 16.0,
//           mainAxisSpacing: 16.0,
//           childAspectRatio: 1.4,
//         ),
//         itemCount: subjects.length,
//         itemBuilder: (context, index) {
//           final subject = subjects[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SubjectDetailsPage(subject: subject),
//                 ),
//               );
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16.0),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 0,
//                     blurRadius: 10,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: subject['color'].withOpacity(0.1),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(
//                         subject['icon'],
//                         color: subject['color'],
//                         size: 24,
//                       ),
//                     ),
//                     const SizedBox(height: 12.0),
//                     Text(
//                       subject['name'],
//                       style: GoogleFonts.poppins(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: const Color(0xFF2D3748),
//                       ),
//                     ),
//                     const SizedBox(height: 4.0),
//                     Row(
//                       children: [
//                         Text(
//                           '${subject['chapters']} chapters',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: const Color(0xFF718096),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Container(
//                           width: 4,
//                           height: 4,
//                           decoration: const BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Color(0xFF718096),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           '${subject['games']} games',
//                           style: GoogleFonts.poppins(
//                             fontSize: 12,
//                             color: const Color(0xFF718096),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subject_details_page.dart';

class AllSubjectsPage extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const AllSubjectsPage({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 135.0,
            floating: true,
            pinned: true,
            backgroundColor: const Color(0xFF5A6BF5),
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'All Subjects',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              background: Stack(
                children: [
                  // Background pattern
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF5A6BF5), Color(0xFF5A6BF5)],
                        ),
                      ),
                      child: Opacity(
                        opacity: 0.2,
                        child: CustomPaint(
                          painter: PatternPainter(),
                          size: Size.infinite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Subjects Grid
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.4,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final subject = subjects[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SubjectDetailsPage(subject: subject),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(25), // 0.1 * 255 = 25
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: subject['color'].withAlpha(
                                25,
                              ), // 0.1 * 255 = 25
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              subject['icon'],
                              color: subject['color'],
                              size: 32,
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            subject['name'],
                            style: GoogleFonts.poppins(
                              fontSize: 25,
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
                                  color: const Color(0xFF718096),
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
                                  color: const Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: subjects.length),
            ),
          ),
        ],
      ),
    );
  }
}

// Background pattern painter
class PatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withAlpha(51) // 0.2 * 255 = 51
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;

    final double spacing = 20.0;

    // Draw grid lines
    for (double i = 0; i < size.width; i += spacing) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }

    for (double i = 0; i < size.height; i += spacing) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    // Draw random circles
    final circlePaint =
        Paint()
          ..color = Colors.white.withAlpha(38) // 0.15 * 255 = 38
          ..style = PaintingStyle.fill;

    final random = DateTime.now().millisecondsSinceEpoch;
    for (int i = 0; i < 10; i++) {
      final x = ((random + i * 7) % size.width.toInt()).toDouble();
      final y = ((random + i * 13) % size.height.toInt()).toDouble();
      final radius = 5.0 + (i * 3);
      canvas.drawCircle(Offset(x, y), radius, circlePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
