import 'package:flutter/material.dart';

class Rev_Pop extends StatefulWidget {
  @override
  _Rev_PopState createState() => _Rev_PopState();
}

class _Rev_PopState extends State<Rev_Pop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      child: SimpleDialog(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonTheme(
              child: Row(children: [
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  color: Colors.redAccent,
                  child: Text('Changer'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  color: Theme.of(context).accentColor,
                  child: Text('Laisser la photo'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
