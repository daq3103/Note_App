import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgLogin extends StatelessWidget {
  const SvgLogin({super.key, required this.svgLink});
  final String svgLink;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(31, 95, 62, 62),
      ),
      child: InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            svgLink,
          )),
    );
  }
}
