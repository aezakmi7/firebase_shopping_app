import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: _groceryItems.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(_groceryItems[index].id),
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              borderRadius: BorderRadius.circular(17)),
        ),
        child: ListTile(
          title: Text(_groceryItems[index].name),
          leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color),
          trailing: Text(
            _groceryItems[index].quantity.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        onDismissed: (direction) {
          setState(() {
            _groceryItems.removeAt(index);
          });
        },
      ),
    );

    if (_groceryItems.isEmpty) {
      content = const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Oh no! Nothing here!',
            ),
            SizedBox(height: 16),
            Text(
              'You can add some groceries by pressing "+" button',
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Grocery List'),
          actions: [
            IconButton(
              onPressed: _addItem,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: content);
  }
}
