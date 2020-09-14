import 'package:flutter/material.dart';
import 'homescrean.dart';

class TaskDetails extends StatefulWidget {

  _TaskDetailsState createState() => _TaskDetailsState();
}

class _TaskDetailsState extends State<TaskDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerCodeOnly(),
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text("Tasks Details",style: TextStyle(
              color: Colors.white,
            ),),
            actions:<Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
              ),

              FlatButton(
                child: new Text('Logout',style: new TextStyle(fontSize:17.0,color:Colors.white)),
                onPressed: (){
                  //AuthService().signOut();
                },
              ),
            ]),
        body: Container(
                    //height: 50,
                    // width: 500,
                    margin: EdgeInsets.only(top: 10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          child: Form(
                            child: Padding(padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                //from here
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 5, 200, 0),
//                            padding: EdgeInsets.symmetric(
//                                horizontal: 90.0, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(143, 148, 251, 3),
                                          blurRadius: 3.0,
                                          offset: Offset(0, 10),
                                        )
                                      ]),
                                  //copy here
                                  child: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.fromLTRB(50, 0, 200, 0)),
                                  Padding(padding: EdgeInsets.symmetric(
                                      horizontal: 90.0, vertical:0)),
                                      Container(
                                        child: FlatButton(
                                          onPressed: () {},
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0)),
                                          child: Text('New'),
                                        ),
                                      ),
                                      Container(
                                        child: FlatButton(
                                          onPressed: () {},
                                          color: Colors.orange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(20.0)),
                                          child: Text('New'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                   // controller: emailController,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    // controller: emailController,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    // controller: emailController,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    // controller: emailController,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    // controller: emailController,
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Container(
                                  child: FlatButton(
                                    onPressed: () {},
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(0)),
                                    child: Text('Save'),
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                //Text('Comment'),
                                Card(
                                  child: Container(
                                    width: 500,
                                    height: 150,
                                    child: SizedBox(
                                     // child: Row()
                                      child: Container(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            hintText: 'Comment',
                                              border: OutlineInputBorder()),
                                          // controller: emailController,
                                        ),

                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

    );
  }
}
