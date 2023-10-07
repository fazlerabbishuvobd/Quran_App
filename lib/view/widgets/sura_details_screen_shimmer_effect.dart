import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class SuraDetailsScreenShimmerEffect extends StatefulWidget {
  const SuraDetailsScreenShimmerEffect({super.key});

  @override
  State<SuraDetailsScreenShimmerEffect> createState() => _SuraDetailsScreenShimmerEffectState();
}

class _SuraDetailsScreenShimmerEffectState extends State<SuraDetailsScreenShimmerEffect> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: 200.0,
          height: 100.0,
          child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  height: height*0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                Container(
                  height: height*0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                const Spacer(),

                Container(
                  height: height*0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20)
              ],
            )
          ),
        ),
      ),
    );
  }
}
