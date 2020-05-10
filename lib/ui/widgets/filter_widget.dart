
import 'package:flutter/material.dart';
import 'package:puzzlechat/data/filter.dart';


class FilterWidget extends StatelessWidget {

  final Filter filter;
  final Function onTap;

  FilterWidget({@required this.filter, @required this.onTap});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            child: TweenAnimationBuilder(
              tween: ColorTween(begin: Colors.white,end: Color(filter.endColor)),
              duration: Duration(milliseconds: 0),
              builder: (_, Color color,__){
                return ColorFiltered(
                  colorFilter: ColorFilter.mode(color, BlendMode.modulate),
                  child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: FileImage(filter.imageFile),
                ),
                );
              },

            ),
          ),
          Text(
            filter.filterName,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
