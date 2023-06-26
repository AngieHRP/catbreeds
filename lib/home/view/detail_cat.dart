import 'package:catbreeds/home/view/widgets/widgets_home.dart';
import 'package:catbreeds/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:catbreeds/widgets/body_app.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/strings.dart';
import '../model/catbreeds.dart';


class DetailCat extends StatefulWidget {

  const DetailCat({Key? key, required this.dataCat}) : super(key: key);

  final CatbreedsModel dataCat;

  @override
  State<DetailCat> createState() => DetailCatState();
}

class DetailCatState
    extends State<DetailCat> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        body: BodyApp(
          onBack: true,
          marginBody: false,
          childHeader: Container(),
          childBody: bodyDetail(),
          onBackPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  Widget bodyDetail(){
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.50,
            child: FadeInImage(
              image: NetworkImage(
                  "${Constants.urlImage}${widget.dataCat.referenceImageId}.jpg"),
              placeholder: const AssetImage(
                  'assets/icon_image.png'),
              imageErrorBuilder:
                  (context, error, stackTrace) {
                return Container(
                    color: Colors.white,
                    child: Image.asset('assets/image.png'),
                );
              },
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.40),
            padding: const EdgeInsets.only(top: 30, left: 25, right: 25, bottom: 25),
            decoration:  const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              color: Color.fromRGBO(246, 246, 246, 1),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      widget.dataCat.name!,
                      style: const TextStyle(
                        color: Color.fromRGBO(100, 76, 100, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  itemDetail(Strings.description, widget.dataCat.description!),
                  itemDetail(Strings.origin, widget.dataCat.origin!),
                  itemDetail(Strings.temperament, widget.dataCat.temperament!),
                  itemDetail(Strings.lifeSpan, widget.dataCat.lifeSpan!),
                  itemDetail(Strings.adaptability, widget.dataCat.adaptability!.toString()),
                  itemDetail(Strings.energyLevel, widget.dataCat.energyLevel!.toString()),
                  itemDetail(Strings.intelligence, widget.dataCat.intelligence!.toString()),
                  Visibility(
                      visible: widget.dataCat.vetstreetUrl != null,
                      child: buttonReference(Strings.viewMore,  () {
                    _launchUrl(widget.dataCat.vetstreetUrl!);
                  }, 120, 40))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

}
