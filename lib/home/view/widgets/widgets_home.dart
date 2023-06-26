import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
import '../../../utils/scale_route.dart';
import '../../../utils/strings.dart';
import '../../../widgets/widgets_generics.dart';
import '../../model/catbreeds.dart';
import '../detail_cat.dart';

Widget shimmerHome(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: 6,
    padding: const EdgeInsets.only(
        top: 20.0, bottom: 20.0),
    itemBuilder: (context, index) => homeShimmer(context),
  );
}

Widget homeShimmer(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
    decoration:  BoxDecoration(
        border: Border.all(color: Colors.white.withOpacity(0.4)),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        )),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.4),
          decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: Colors.white),
          child:   const ParagraphShimmer(lines: 3, space: 5, height: 20),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
        //  child: Image.asset('assets/icon_image.png'),
        ),
      ],
    ),
  );
}

Widget itemCat(CatbreedsModel data, BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
      child: Stack(
        alignment: Alignment.centerLeft,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(15),
          margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.4),
          decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name!,
                style: const TextStyle(
                  color: Color.fromRGBO(100, 76, 100, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                )
              ),
              const SizedBox(height: 5),
              Text(
                  data.origin!,
                  style: const TextStyle(
                    color: Color.fromRGBO(100, 76, 100, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  )
              ),
              const SizedBox(height: 15),
              Container(
                alignment: Alignment.centerRight,
                child: buttonReference(Strings.detail,  () {
                  Navigator.push(context, ScaleRoute(page: DetailCat(dataCat: data)));
                }, 70, 30),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(0.1),
                  blurRadius: 10.0,
                ),
              ],
              borderRadius: const BorderRadius.all( Radius.circular(20.0)),
            ),
            child: ClipRRect(
              borderRadius:
              BorderRadius.circular(
                  20.0),
              child: FadeInImage(
                image: NetworkImage(
                    "${Constants.urlImage}${data.referenceImageId}.jpg"),
                placeholder: const AssetImage(
                    'assets/icon_image.png'),
                imageErrorBuilder:
                    (context, error, stackTrace) {
                  return Container(
                      color: Colors.white,
                      child:  Image.asset('assets/image.png'),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buttonReference(String title, Function onSelect, double width, double height) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(180, 168, 187, 1),
              Color.fromRGBO(150, 114, 132, 1),
              Color.fromRGBO(100, 76, 100, 1),
            ],
            stops: [0.1,0.6,0.9],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter),
        borderRadius: BorderRadius.circular(5),
    ),
    child: ElevatedButton(
      onPressed: () {
        onSelect();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero, // Set this
        padding: EdgeInsets.zero,
        primary: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        //make color or elevated button transparent
      ),
      child: Container(
          alignment: Alignment.center,
          child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )
          ),
      ),
    ),
  );
}

Widget itemDetail(String title, String data) {
  return Container(
    alignment: Alignment.centerLeft,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            title,
            style: const TextStyle(
              color: Color.fromRGBO(100, 76, 100, 1),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            )
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
            data,
            style: const TextStyle(
              color : Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            )
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    ),
  );
}

