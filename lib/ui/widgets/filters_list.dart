import 'package:flutter/material.dart';
import 'package:puzzlechat/data/filter.dart';
import 'package:puzzlechat/ui/widgets/filter_widget.dart';

class FiltersList extends StatelessWidget {

  final List<Filter> filters;

  FiltersList({@required this.filters});

  @override
  Widget build(BuildContext context) {
       return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: filters.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (context, index) {
        final imagePiece = filters[index];

        //Building a single ImagePieceWidget details UI for any index.
        return FilterWidget(
                filter: filters[index],
              );
      },
    );
  }
}
