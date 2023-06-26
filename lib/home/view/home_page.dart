import 'package:catbreeds/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:catbreeds/home/view/widgets/widgets_home.dart';
import 'package:catbreeds/widgets/body_app.dart';
import 'package:catbreeds/widgets/empty_view.dart';
import 'package:catbreeds/widgets/no_internet.dart';

import '../../app/base_page.dart';
import '../../utils/scale_route.dart';
import '../bloc/home_bloc.dart';
import '../model/catbreeds.dart';
import 'detail_cat.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState
    extends BasePage<HomePage, HomeBloc> {

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc!.getCatbreeds();
  }

  @override
  void dispose() {
    super.dispose();
    editingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BodyApp(
          onBack: false,
          marginBody: true,
          childHeader: bodyHeader(),
          childBody: bodyHome(),
        ),
      ),
    );
  }

  Widget bodyHeader(){
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      color: Colors.white,
      child: Column(
        children: [
          const Text(
              Strings.nameApp,
              style: TextStyle(
                color: Color.fromRGBO(100, 76, 100, 1),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
          ),
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25, top: 15, ),
            child: TextField(
              onChanged: (value) {
                if(value.isNotEmpty){
                  bloc!.filterSearchResults(value);
                } else {
                  bloc!.cleanSearch();
                }
              },
              controller: editingController,
              style: const TextStyle(
                color: Color.fromRGBO(100, 76, 100, 1),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                  hintText: Strings.search,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Icons.search, color:Colors.grey.withOpacity(0.5)),
                  focusColor: Colors.grey.withOpacity(0.5),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(0.5),
                    ),
                      borderRadius: const BorderRadius.all(Radius.circular(5.0)))),
            ),
          ),
        ],
      ),
    );
  }

    Widget bodyHome(){
    return  Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.35),
      decoration:  const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        color: Color.fromRGBO(246, 246, 246, 1),
      ),
      child:  StreamBuilder<bool>(
          stream: bloc!.isLoadingStream,
          builder: (context, snapshotLoading) {
            var loading = true;
            if (snapshotLoading.hasData) {
              loading = snapshotLoading.data!;
            }
            return StreamBuilder (
              stream: bloc!.listSearchStream,
              builder: (context, snapshot) {
                List<CatbreedsModel> data = [];
                if (snapshot.hasData) {
                  data = snapshot.data!;
                }
                return StreamBuilder (
                  stream: bloc!.typeErrorStream,
                  builder: (context, snapshotError) {
                    var typeError = "";
                    if (snapshotError.hasData) {
                      typeError = snapshotError.data!;
                    }
                    return loading ? shimmerHome(context) : viewCats(data, typeError);
                  },
                );
              },
            );
          },
        ),
    );
  }

  Widget viewCats(List<CatbreedsModel> data, String typeError) {
    return  data.isNotEmpty ? viewListCats(data) :
     typeError == "noInternet" ? const NoInternet()  : const EmptyView();
  }

  Widget viewListCats(List<CatbreedsModel> data) {
    return ListView.builder(
        itemCount: data.length,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
        itemBuilder: (_, index) {
          return  itemCat(data[index], context);
        });
  }


}
