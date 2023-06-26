import 'package:flutter/material.dart';

import '../utils/strings.dart';

class EmptyView extends StatelessWidget {


  const EmptyView({super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children:  [
          SizedBox(
              width: 200,
              height: 200,
              child: Image.asset('assets/icon_image.png')
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
              Strings.errorGeneric,
              style: TextStyle(
                color: Color.fromRGBO(100, 76, 100, 1),
              )
          ),
        ],
      ),
    );
  }
}



