import 'dart:math';
import 'package:flutter/material.dart';

class Floorplan extends StatelessWidget {
  // Define the dimensions of the grid
  final int numRows = 8;
  final int numColumns = 9;

  // Function to generate random number of rooms based on the formula
  double generateNumberOfRooms(int level) {
    Random random = Random();
    int randomValue =
        random.nextInt(3); // Generates random number between 0 and 2
    return 5 + level * 2.6 + randomValue;
  }

  @override
  Widget build(BuildContext context) {
    int level = 1; // Assuming level 1 for demonstration

    // Generate the number of rooms
    int numRooms = generateNumberOfRooms(level).toInt();

    // Generate the grid
    List<List<int>> grid = List.generate(numRows, (y) {
      return List.generate(numColumns, (x) {
        // Calculate the cell number based on the given formula
        int cellNumber = (y + 1) * 10 + (x + 1);
        return cellNumber;
      });
    });

    // Convert grid into a widget
    List<Widget> rows = [];
    for (int y = 0; y < numRows; y++) {
      List<Widget> cells = [];
      for (int x = 0; x < numColumns; x++) {
        cells.add(Container(
          width: 50, // Adjust width as needed
          height: 50, // Adjust height as needed
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: Text(
            '${grid[y][x]}',
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ));
    }

    // Build the grid
    return Scaffold(
      appBar: AppBar(
        title: Text('Floorplan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Number of Rooms: $numRooms'),
            SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: rows,
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Floorplan(),
  ));
}
