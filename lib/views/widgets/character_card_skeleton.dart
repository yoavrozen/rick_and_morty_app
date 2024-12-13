import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../consts/consts.dart';
import '../../theme/text_theme.dart';

class CharacterCardSkeleton extends StatelessWidget {
  const CharacterCardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Consts.deepSpaceBlue,
              Consts.indigo,
              Colors.black,
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: const Bone.circle(size: 48),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Placeholder Name",
                  style: nameStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("Status", style: statusStyle),
              ),
            ],
          ),
          trailing: const Skeleton.ignore(
              child: Icon(Icons.more_horiz, color: Colors.grey)),
          subtitle: Text(
            "Species",
            style: speciesStyle,
          ),
        ),
      ),
    );
  }
}
