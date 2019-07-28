import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(home: MyApp()),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'to do list with Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: ToDoWidget(title: 'to do list with Flutter'),
    );
  }
}


class ToDoWidget extends StatefulWidget {
  ToDoWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}


class _ToDoWidgetState extends State<ToDoWidget> {

  List<String> _todoItems = [];

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('To do list')
      ),

      // drawer: new Drawer(
      //   child: new ListView(
      //     children: <Widget> [
      //       // new DrawerHeader(child: new Text('Menu'),),
      //       new ListTile(
      //         title: new Text('Setting'),
      //         leading: Icon(Icons.settings),
      //         // isThreeLine: true,
      //         onTap: () {},
      //       ),
      //       new ListTile(
      //         title: new Text('About'),
      //         onTap: () {},
      //       ),
      //     ],
      //   )
      // ),
      
      body: _buildTodoList(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _pushAddTodoScreen,
        tooltip: 'Add task',
        child: new Icon(Icons.add)
      ),
    );
  }


  Widget _buildTodoList() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _todoItems.length) {
          return _buildTodoItem(_todoItems, index);
        }
      },
    );
  }


  void _addTodoItem(String task) {
    if(task.length > 0) {
      setState(() => _todoItems.add(task));
    }
  }




  Widget _buildTodoItem(_todoItems, index) {
    String todoText = _todoItems[index];

    return Dismissible(
      key: Key(todoText),

      onDismissed: (direction) {
        setState(() {
          _todoItems.removeAt(index);
        });
      },
      background: Container(color: Colors.grey),

      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: Icon(Icons.check_circle_outline),
              title: new Text(todoText),
              onTap: (){},
            ),
          ]
        ),
      ),
    );
  }


  void _pushAddTodoScreen() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Add a new task')
            ),

            body: new TextField(
              autofocus: true,
              onSubmitted: (val) {
                _addTodoItem(val);
                Navigator.pop(context);
              },
              decoration: new InputDecoration(
                hintText: 'What is next task?',
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }

}
