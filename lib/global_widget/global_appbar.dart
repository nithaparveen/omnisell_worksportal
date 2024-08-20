import 'package:flutter/material.dart';

import '../core/constants/colors.dart';
import '../core/constants/textstyles.dart';

class GLAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? centerTitle;
  final bool? forceMaterialTransparency;

  const GLAppBar({
    super.key,
    this.title,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.forceMaterialTransparency = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title!, style: GLTextStyles.cabinStyle(size: 22)),
      centerTitle: centerTitle,
      backgroundColor: ColorTheme.white,
      surfaceTintColor: ColorTheme.white,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
