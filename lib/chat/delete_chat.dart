import 'package:flutter/material.dart';


class MyContainer extends StatefulWidget {
  @override
  _MyContainerState createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  bool _showDeleteContainer = false;

  void _handleLongPress() {
    setState(() {
      _showDeleteContainer = true;
    });

    // Show the delete bottom sheet
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: Icon(Icons.delete, color: Colors.red),
                title: Text(
                  'Delete',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle the delete action here
                  _hideDeleteContainer();
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
              SizedBox(height: 16),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.cancel, color: Colors.grey),
                title: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
              ),
            ],
          ),
        );
      },
    );

  }

  void _hideDeleteContainer() {
    setState(() {
      _showDeleteContainer = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Long Press Example'),
      ),
      body: Center(
        child: GestureDetector(
          onLongPress: _handleLongPress,
          onLongPressEnd: (details) {
            _hideDeleteContainer();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(
                  child: Text('Long press me'),
                ),
              ),
              if (_showDeleteContainer)
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.red.withOpacity(0.8),
                  child: Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
