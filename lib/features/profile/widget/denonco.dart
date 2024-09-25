import 'package:flutter/material.dart';
import 'package:koha/core/widgets/dashed_border_painter.dart';

class DenoncoScreen extends StatelessWidget {
  const DenoncoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Denonco',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Lorem ipsum dolor sit amet consectetur. Lectus sed amet dolor duis nec et placerat facilisis. Cursus id velit.',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 24),
            const Text('Emri',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Mbiemri',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 8),
            const Text('Email',
                style: TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 24),
            SizedBox(
              height: 50, // Adjust this value as needed
              child: CustomPaint(
                painter: DashedBorderPainter(allSides: true),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Titulli',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: CustomPaint(
                painter: DashedBorderPainter(allSides: true),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const TextField(
                    style: TextStyle(color: Colors.white),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'shkruaj ketu..',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('ngarko'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('dergo'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
