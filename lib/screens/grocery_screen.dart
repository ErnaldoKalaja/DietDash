import 'package:flutter/material.dart';

import '../model/grocery_item.dart';
import 'empty_grocery_screen.dart';
import 'grocery_item_screen.dart';
import 'grocery_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';

final groceryItems = <GroceryItem>[];

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Shopping List',
          style: GoogleFonts.lato(fontWeight: FontWeight.w800),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroceryItemScreen(
                onCreate: (item) {
                  groceryItems.add(item);
                  Navigator.pop(context);
                  setState(() {});
                },
                onUpdate: (item) {},
              ),
            ),
          );
        },
      ),
      body: buildGroceryScreen(),
    );
  }

  Widget buildGroceryScreen() {
    if (groceryItems.isNotEmpty) {
      return GroceryListScreen(
        groceryItems: groceryItems,
      );
    } else {
      return const EmptyGroceryScreen();
    }
  }
}
