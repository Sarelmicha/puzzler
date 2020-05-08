import 'package:flutter/material.dart';
import 'package:puzzlechat/bloc/edit_image_screen_bloc/edit_image_screen_bloc.dart';
import 'package:puzzlechat/data/filter.dart';
import 'package:puzzlechat/ui/screens/edit_image_screen.dart';
import 'package:puzzlechat/ui/widgets/filter_widget.dart';

class FiltersList extends StatelessWidget {

  final List<Filter> filters;
  final EditImageScreenBloc bloc;

  FiltersList({@required this.filters, @required this.bloc});

  @override
  Widget build(BuildContext context) {
       return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: filters.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {

        //Building a single ImagePieceWidget details UI for any index.
        return FilterWidget(
                filter: filters[index],
                onTap: (){
                  //TODO - when click change the color
                  bloc.add(filters[index].event);
                },
              );
      },
    );
  }
}
