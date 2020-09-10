import 'package:flutter/material.dart';
import 'homescrean.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
//import 'package:animated_theme_switcher/animated_theme_switcher.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:line_awesome_flutter/line_awesome_flutter.dart';


class Profile extends StatefulWidget {
//  final Widget child;
//  Profile({Key key,this.child}): super(key: key);

  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  File imageFile;

  _openGallery(BuildContext context) async{
    imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      File picture;
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      File picture;
      imageFile = picture;
    });
    Navigator.of(context).pop();
  }

Future<void> _showChoiceDialog (BuildContext context){
  return showDialog(context: context,builder: (BuildContext context){
    return AlertDialog(
      title: Text("Make A Choice!"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              child: Text("Gallery"),
              onTap: (){
                _openGallery(context);
              },
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            GestureDetector(
              child: Text("Camera"),
              onTap: (){
                _openCamera(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  );
}

Widget _ImageView(){
    if(imageFile == null){
      return Text("No Image Selected");
    } else{
  Image.file(imageFile,width: 200, height: 200);
  }
}


  @override
  Widget build(BuildContext context) {
   // ScreenUtil.init(context,height: 869,width: 414, allowFontScaling: true);
    return Scaffold(
        drawer: DrawerCodeOnly(),
        appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text("Profile",style: TextStyle(
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
      body: Column(
        children: <Widget>[
          SizedBox(width: 50),
//          Icon(LineAwesomeIcons.arrow_left,size: ScreenUtil().setSp(300)
//          ),
          Expanded(
            child: Column(
              children: <Widget>[
              Container(
                //height: 50,
               // width: 500,
               margin: EdgeInsets.only(top: 10),
                child: Stack(
                  children: [ CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/logo1.png"),
                  ),
                    Text("* Required field",textAlign: TextAlign.right),
                   ],
                ),
              ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 200,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(20),
//                    color: Colors.blue
//                  ),
                  child: Center(
                    child: FlatButton(
                    color: Colors.blue,
                      child: new Text('Upload Profile Picture',style: new TextStyle(fontSize:17.0,color:Colors.white)),
                    onPressed: (){
                      _showChoiceDialog(context);
                    },
                  ),
                ))
               ],
            ),
          ),
//          Icon(LineAwesomeIcons.sun,size: ScreenUtil().setSp(300)
//          ),
          SizedBox(width: 20),
          Expanded(child: ListView(
            children: <Widget>[
              ProfileListItem(
                text: 'Fisrt Name  *',
              ),
              ProfileListItem(
                text: 'Last Name  *',
              ),
              ProfileListItem(
                text: 'Company  *',
              ),
              ProfileListItem(
                text: 'Employee Position  *',
              ),
              ProfileListItem(
                text: 'Contact Number  *',
              ),
              ProfileListItem(
                text: 'Email  *',
              ),
              ProfileListItem(
                text: 'Password  *',
              ),
//              ProfileListItem(
//                text: 'Save',
//              ),
            ],
          ))
        ],
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget{
  final IconData icon;
  final text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation,
}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
        alignment: Alignment.topRight,
       // margin: EdgeInsets.fromLTRB(0, 0, 20, 0),

      child: Form(child: Padding(padding: EdgeInsets.fromLTRB(20, 2, 50, 0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 200, 0),
              child:  Text(this.text),
            ),
            Container(
              padding:EdgeInsets.fromLTRB(5, 0, 0, 0),
              child:  TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder()),
              ),
            ),
          ],
        ),
    ),
      ),
     );
  }
}













