import 'package:flutter/material.dart';
import 'package:flutter_beautiful_care_web/data/category_repository.dart';
import 'package:flutter_beautiful_care_web/data/models/post.dart';
import 'package:provider/provider.dart';

class DetailPostWidget extends StatefulWidget {
  final String id;

  DetailPostWidget(this.id);

  @override
  _DetailPostWidgetState createState() => _DetailPostWidgetState();
}

class _DetailPostWidgetState extends State<DetailPostWidget> {

  Post data;

  VoidCallback onLoad;

  CategoryRepository categoryRepository;

  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    categoryRepository = Provider.of(context,listen: false);
    onLoad = (){
      data = null;
      categoryRepository.getPostId(widget.id).then((value){
        debugPrint('DetailPostWidget data : $value');
      });
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    categoryRepository.getPostId(widget.id).then((value){
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(28),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                  child: Text(
                    'Thông tin bài viết',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Theme.of(context).primaryColor
                    ),
                  )
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 200,
                    child: Text(
                      'Tiêu Đề Bài Viết :'
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 52,
                      padding: EdgeInsets.only(left: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue,
                          width: 2
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: TextFormField(
                        initialValue: data?.title,
                        decoration: InputDecoration(
                          hintText: 'Tiêu Đề Bài Viết',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}