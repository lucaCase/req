import 'package:flutter/material.dart';
import 'package:req/components/collections/collection_selection.dart';
import 'package:req/components/collections/collection_view.dart';

class Collection extends StatelessWidget {
  Collection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CollectionView(),
        CollectionSelection(),
      ],
    );
  }
}
