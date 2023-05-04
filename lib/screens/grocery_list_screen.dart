// ignore_for_file: lines_longer_than_80_chars
import 'package:flutter/material.dart';
import '../components/grocery_tile.dart';

import '../model/grocery_item.dart';
import 'grocery_item_screen.dart';

class GroceryListScreen extends StatefulWidget {
  final List<GroceryItem> groceryItems;

  const GroceryListScreen({
  super.key,
  required this.groceryItems,
  });

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: widget.groceryItems.length,
        itemBuilder: (context, index) {
          final item = widget.groceryItems[index];
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete_forever,
                    color: Colors.white, size: 50.0)),
            onDismissed: (direction) {
              widget.groceryItems.removeAt(index);
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} dismissed')));
            },
            child: InkWell(
              child: GroceryTile(
                  key: Key(item.id),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      final item = widget.groceryItems[index];
                      widget.groceryItems[index] =
                          item.copyWith(isComplete: change);
                    }
                  }),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      onUpdate: (item) {
                        widget.groceryItems[index] = item;
                        Navigator.pop(context);
                      },
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16.0);
        },
      ),
    );
  }
}
