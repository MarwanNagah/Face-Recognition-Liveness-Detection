import 'package:flutter/material.dart';
import 'package:getflutter/components/rating/gf_rating.dart';

class Review extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReviewState();
  }
}

class ReviewState extends State<Review> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  double _rating = 1;
  double count = 1;

  get rating => null;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: BackButton(),
        title: new Text(
          "Review",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: new Container(
          padding: const EdgeInsets.all(20.0), child: formSetup(context)),
    ));
  }

  Widget formSetup(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new ListView(
        children: <Widget>[
          new Text(
            'Review',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w700,
                fontSize: 40),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          new Text(
            'Rating',
            style: TextStyle(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w700,
                fontSize: 27),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 20.0),
          ),
          GFRating(
            color: Colors.yellow,
            borderColor: Colors.grey,
            value: _rating,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new Text(
            'Comment',
            style: TextStyle(
                color: Colors.greenAccent[400],
                fontWeight: FontWeight.w700,
                fontSize: 27),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new TextField(
            style: TextStyle(height: 3),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 3,
                  style: BorderStyle.none,
                ),
              ),
              labelText: 'write your comment',
            ),
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 40.0),
          ),
          new RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: new Text("Submit"),
            onPressed: () {},
            color: Colors.greenAccent[400],
            highlightColor: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
