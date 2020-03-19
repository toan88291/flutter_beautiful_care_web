import 'package:flutter/material.dart';

class HeaderPostWidget extends StatelessWidget {
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
          Container(
            width: 40,
            alignment: Alignment.center,
            child: Text('STT', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Tên Bài Viết', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Danh Mục', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Media', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Like', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Thao tác', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
        ],
      ),
    );
  }
}
