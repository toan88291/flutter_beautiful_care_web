import 'package:flutter/material.dart';

class HeaderPatientSmallWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(child: Container(
            padding: EdgeInsets.all(8),
            child: Text('Tên trường', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.all(8),
            child: Text('Nội dung', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
        ],
      ),
    );
  }
}
