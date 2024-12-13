import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/views/widgets/character_card_skeleton.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingListSkeleton extends StatelessWidget {
  const LoadingListSkeleton({super.key, required this.actionsBarWidget});

  final Widget actionsBarWidget;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: Colors.grey[600] ?? Colors.grey,
        highlightColor: Colors.grey[100] ?? Colors.grey,
        duration: const Duration(milliseconds: 1500),
      ),
      child: Column(children: [
        actionsBarWidget,
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const CharacterCardSkeleton();
            },
          ),
        ),
      ]),
    );
  }
}
