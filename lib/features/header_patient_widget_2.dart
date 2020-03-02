import 'package:flutter/material.dart';

class HeaderPatientWidget2 extends StatelessWidget {
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
            child: Text('Tên bệnh nhân', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Mã bệnh nhân', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Địa chỉ', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Ngày sinh', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Email', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Giới tính', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Điện thoại', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('Bảo hiểm', style: Theme.of(context).primaryTextTheme.subtitle),
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
