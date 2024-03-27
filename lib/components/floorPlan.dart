import 'dart:math';
import 'package:flutter/material.dart';

class Floorplan extends StatelessWidget {
  // Define the dimensions of the grid
  final int numRows = 8;
  final int numColumns = 9;
  final int startingRoom = 35;

  final List<int> rooms = [
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89
  ];

  // Function to generate room IDs based on the floorplan
  List<String> generateRoomIDs() {
    List<String> roomIDs = [];
    // Assuming there is a specific format for room IDs
    for (int roomNumber in rooms) {
      roomIDs.add('Room $roomNumber');
    }
    return roomIDs;
  }

  // Function to generate random number of rooms based on the formula
  int generateNumberOfRooms(int level) {
    Random random = Random();
    int randomValue =
        random.nextInt(3); // Generates random number between 0 and 2
    return (5 + level * 2.6 + randomValue).toInt();
  }

  // Function to check if a cell is valid for room placement
  bool isValidCell(int cell, List<int> rooms) {
    return cell >= 11 && cell <= 78 && !rooms.contains(cell);
  }

  // Function to check if a cell is a dead end
  bool isDeadEnd(int cell, List<int> rooms) {
    int filledNeighbors = 0;
    List<int> directions = [10, -10, 1, -1];
    for (int dir in directions) {
      int neighbor = cell + dir;
      if (rooms.contains(neighbor)) {
        filledNeighbors++;
      }
    }
    return filledNeighbors < 2;
  }

  // Function to check if the floorplan is consistent
  bool isFloorplanConsistent(
      int numRooms, List<int> rooms, List<int> endRooms) {
    return rooms.length == numRooms &&
        !endRooms.contains(startingRoom + 10) &&
        !endRooms.contains(startingRoom - 10) &&
        !endRooms.contains(startingRoom + 1) &&
        !endRooms.contains(startingRoom - 1);
  }

  // Function to place a secret room
  int placeSecretRoom(List<int> rooms, List<int> endRooms) {
    Random random = Random();
    int attempts = 0;
    while (attempts < 600) {
      int cell = random.nextInt(65) + 11; // Random cell between 11 and 78
      if (rooms.contains(cell) ||
          endRooms.contains(cell) ||
          isDeadEnd(cell, rooms)) {
        attempts++;
        continue;
      }

      // Check if the cell is next to at least three rooms and not next to any end rooms
      int filledNeighbors = 0;
      List<int> directions = [10, -10, 1, -1];
      for (int dir in directions) {
        int neighbor = cell + dir;
        if (rooms.contains(neighbor) && !endRooms.contains(neighbor)) {
          filledNeighbors++;
        }
      }

      if (filledNeighbors >= 3) {
        debugPrint("Placed secret room at cell: $cell");
        return cell;
      }

      attempts++;
    }
    debugPrint("Failed to place secret room.");
    return -1; // Failed to place the secret room
  }

  // Function to generate room names based on the generated rooms
  List<String> generateRoomNames(List<int> rooms) {
    List<String> roomNames = [];
    for (int room in rooms) {
      roomNames.add('Room $room');
    }
    return roomNames;
  }

  @override
  Widget build(BuildContext context) {
    int level = 1; // Assuming level 1 for demonstration

    // Generate the number of rooms
    int numRooms = generateNumberOfRooms(level);

    // Room placement
    List<int> rooms = [startingRoom];
    List<int> queue = [startingRoom];
    List<int> endRooms = [];

    // Directions: +10/-10/+1/-1
    List<int> directions = [10, -10, 1, -1];

    while (queue.isNotEmpty && rooms.length < numRooms) {
      int currentRoom = queue.removeAt(0);
      bool isDeadEnd =
          true; // Flag to determine if the current room is a dead end

      for (int direction in directions) {
        int neighbor = currentRoom + direction;

        // Check if neighbor cell is already occupied
        if (!isValidCell(neighbor, rooms)) {
          continue;
        }

        // Count filled neighbors
        int filledNeighbors = 0;
        for (int dir in directions) {
          int neighborCell = neighbor + dir;
          if (rooms.contains(neighborCell)) {
            filledNeighbors++;
          }
        }

        // If neighbor cell has more than one filled neighbor, give up
        if (filledNeighbors > 1) {
          continue;
        }

        // Random 50% chance
        if (Random().nextBool()) {
          continue;
        }

        // Mark neighbor cell as having a room and add it to the queue
        rooms.add(neighbor);
        queue.add(neighbor);
        isDeadEnd = false;
      }

      // If the current room is a dead end, add it to the list of end rooms
      if (isDeadEnd) {
        endRooms.add(currentRoom);
      }

      // Reseed the starting room into the queue periodically for maps needing more than 16 rooms
      if (rooms.length < 16 && rooms.length % 4 == 0) {
        queue.add(startingRoom);
      }
    }

    // Ensure the boss room is not adjacent to the starting room
    while (!isFloorplanConsistent(numRooms, rooms, endRooms)) {
      rooms.clear();
      queue.clear();
      endRooms.clear();
      rooms.add(startingRoom);
      queue.add(startingRoom);
      while (queue.isNotEmpty && rooms.length < numRooms) {
        int currentRoom = queue.removeAt(0);
        bool isDeadEnd = true;

        for (int direction in directions) {
          int neighbor = currentRoom + direction;
          if (!isValidCell(neighbor, rooms)) {
            continue;
          }

          int filledNeighbors = 0;
          for (int dir in directions) {
            int neighborCell = neighbor + dir;
            if (rooms.contains(neighborCell)) {
              filledNeighbors++;
            }
          }

          if (filledNeighbors > 1) {
            continue;
          }

          if (Random().nextBool()) {
            continue;
          }

          rooms.add(neighbor);
          queue.add(neighbor);
          isDeadEnd = false;
        }

        if (isDeadEnd) {
          endRooms.add(currentRoom);
        }
      }
    }

    // Place boss room
    int bossRoom = endRooms.isNotEmpty ? endRooms.last : startingRoom;
    rooms.add(bossRoom);

    // Place secret room
    int secretRoom = placeSecretRoom(rooms, endRooms);
    if (secretRoom != -1) {
      rooms.add(secretRoom);
    }

    // Generate room names
    List<String> roomNames = generateRoomNames(rooms);

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
          child: rooms.contains(grid[y][x])
              ? Icon(Icons.room, size: 24, color: Colors.blue)
              : endRooms.contains(grid[y][x])
                  ? Icon(Icons.door_sliding, size: 24, color: Colors.red)
                  : secretRoom == grid[y][x]
                      ? Icon(Icons.security,
                          size: 24, color: Colors.green) // Secret room icon
                      : bossRoom == grid[y][x]
                          ? Icon(Icons.person,
                              size: 24, color: Colors.orange) // Boss room icon
                          : null,
        ));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cells,
      ));
    }

    // Generate list of room widgets
    List<Widget> roomWidgets = [];
    for (int i = 0; i < rooms.length; i++) {
      roomWidgets.add(
        ListTile(
          leading: Icon(Icons.room, color: Colors.blue),
          title: Text(roomNames[i]),
        ),
      );
    }

    // Build the grid and room list
    return Scaffold(
      appBar: AppBar(
        title: Text('Floorplan'),
      ),
      body: Center(
        child: Row(
          children: [
            // Display the grid
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Number of Rooms: $numRooms'),
                  const SizedBox(height: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: rows,
                  ),
                ],
              ),
            ),
            // Display the list of rooms
            Container(
              width: 200, // Adjust width as needed
              child: ListView(
                children: roomWidgets,
              ),
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
