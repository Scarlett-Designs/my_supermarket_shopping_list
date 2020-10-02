import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    title: "Shopping List",
    theme: ThemeData(
      canvasColor: Color.fromRGBO(231, 231, 222, 1),
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var counter = 0;

  var textController = TextEditingController();
  var popUpTextController = TextEditingController();

  List<String> WidgetList = [];
  static List<bool> selected = [];

  @override
  void dispose() {
    textController.dispose();
    popUpTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Supermarket Shopping List"),
        backgroundColor: Color.fromRGBO(15, 48, 87, 1),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: TextField(
                textInputAction: TextInputAction.go,
                onSubmitted: (text) {
                  if (textController.text.isNotEmpty) {
                    WidgetList.add(text);
                    selected.add(false);
                    setState(() {
                      textController.clear();
                    });
                  }
                },
                decoration: new InputDecoration(
                  fillColor: Colors.blue,
                  hintText: 'Enter Item Here',
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Color.fromRGBO(0, 88, 122, 1),
                    width: 2,
                  )),
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 88, 122, 1)),
                  labelText: 'Add item',
                  prefixIcon: new Icon(Icons.add_box,
                      size: 40.0, color: Color.fromRGBO(0, 136, 145, 1)),
                ),
                style: TextStyle(
                  fontSize: 18.0,
                ),
                controller: textController,
                cursorWidth: 2.0,
                autocorrect: true,
                autofocus: true,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.9,
              child: RaisedButton(
                child: Text("Add"),
                color: Color.fromRGBO(0, 88, 122, 1),
                textColor: Colors.white,
                elevation: 3.0,
                animationDuration: Duration(milliseconds: 5),
                splashColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    WidgetList.add(textController.text);
                    selected.add(false);
                    setState(() {
                      textController.clear();
                    });
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Swipe item left to delete",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: WidgetList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                        background: Container(
                          color: Colors.red[900],
                          alignment: AlignmentDirectional.centerEnd,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            WidgetList.removeAt(index);
                            selected.removeAt(index);
                          });
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("Item deleted")));
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("DELETE"),
                                    color: Colors.red[900],
                                  ),
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                    color: Color.fromRGBO(0, 88, 122, 1),
                                    textColor: Colors.white,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 2),
                            child: selected[index]
                                ? ListTile(
                                    leading: Icon(Icons.check_box,
                                        color: Color.fromRGBO(0, 136, 145, .5)),
                                    title: Text(
                                      WidgetList[index],
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    onTap: () => setState(() =>
                                        selected[index] = !selected[index]),
                                  )
                                : ListTile(
                                    leading: Icon(Icons.check_box_outline_blank,
                                        color: Color.fromRGBO(0, 136, 145, .5)),
                                    title: Text(
                                      WidgetList[index],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    onTap: () => setState(() =>
                                        selected[index] = !selected[index]),
                                  )));
                  }),
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 40.0,
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(15, 48, 87, 1),
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: Icon(
                Icons.home,
                size: 28.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
            ListTile(
              title: Text(
                'About Author',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              leading: Icon(
                Icons.info,
                size: 25.0,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutAuthor()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AboutAuthor extends StatelessWidget {
  nav(BuildContext context) {
    print("About to Navigate");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(15, 48, 87, 1),
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(15, 48, 87, 1),
                Color.fromRGBO(0, 136, 145, 1),
                Color.fromRGBO(231, 231, 222, 1)
              ])),
          child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 110,
                        backgroundColor: Color.fromRGBO(0, 136, 145, 1),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage:
                              AssetImage('assets/images/Avatar.jpeg'),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(15.0)),
                      Text(
                        "Shanann Thompson",
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Software Developer",
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.teal[50],
                          letterSpacing: 2.5,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Divider(
                          color: Color.fromRGBO(231, 231, 222, 1),
                        ),
                      ),
                      Card(
                          color: Color.fromRGBO(231, 231, 222, 0.85),
                          child: ListTile(
                            title: Text(
                              '"Shanann Thompson is an aspiring Software Engineer.'
                              ' She is a final year Computer Science Major with a concentration in Software Engineering at Northern Caribbean University."',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                        width: 200,
                        child: Divider(
                          color: Color.fromRGBO(231, 231, 222, 1),
                        ),
                      ),
                      Text(
                        "SKILLS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box,
                            color: Color.fromRGBO(15, 48, 87, 1)),
                        title: Text(
                          "Desktop, Mobile and Web Application Development",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box,
                            color: Color.fromRGBO(15, 48, 87, 1)),
                        title: Text(
                          "Enterprise Application Development",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box,
                            color: Color.fromRGBO(15, 48, 87, 1)),
                        title: Text(
                          "Microsoft Suite Proficiency",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.add_box,
                            color: Color.fromRGBO(15, 48, 87, 1)),
                        title: Text(
                          "C++, C#, HTML, PHP, MySQL, Java, JavaScript, Java FX, ASP.net.",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
