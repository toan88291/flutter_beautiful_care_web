import 'package:flutter/material.dart';

class HeaderPatientWidget extends StatelessWidget {
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
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Mã Bệnh Án', style: Theme.of(context).primaryTextTheme.subtitle,),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Ngày Khám', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Chuẩn đoán', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Điều trị', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Bác sĩ', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            child: Text('Chú thích', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
          Expanded(child: Container(
            alignment: Alignment.center,
            child: Text('thao tác', style: Theme.of(context).primaryTextTheme.subtitle),
          ),),
        ],
      ),
    );
  }
}
