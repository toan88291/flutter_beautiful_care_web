import 'package:flutter/material.dart';

class HeaderCategoryWidget extends StatelessWidget {
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
            alignment: Alignment.center,
            child: Text('STT', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Tên Danh Mục', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Icon', style: Theme.of(context).primaryTextTheme.subtitle),
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
