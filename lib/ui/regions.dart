import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:poke_flutter/bloc/bloc_provider.dart';
import 'package:poke_flutter/bloc/pokedex_bloc/pokedex_bloc.dart';
import 'package:poke_flutter/bloc/regions_list_bloc/region_list_bloc.dart';
import 'package:poke_flutter/models/location.dart';
import 'package:poke_flutter/ui/region_pokedex.dart';
import 'package:poke_flutter/utils/region_list_map.dart';

class Regions extends StatefulWidget {
  Regions({Key key}) : super(key: key);

  @override
  _RegionsState createState() => new _RegionsState();
}

class _RegionsState extends State<Regions> {
  @override
  Widget build(BuildContext context) {
    return _createPager(context);
  }

  Widget _createPager(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height -
          (_screenSize.height * 0.30 - (MediaQuery.of(context).padding.top)) -
          75.0,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<List<Results>>(
              stream: regionListBloc.regionList,
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    !snapshot.hasData
                        ? CircularProgressIndicator()
                        : SizedBox(
                            height: _screenSize.height * 0.30,
                            child: Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return RegionListModel(
                                  regionModel: snapshot.data[index],
                                  index: index,
                                );
                              },
                              itemCount: snapshot.data.length,
                              itemWidth: _screenSize.width * 0.25,
                              itemHeight: _screenSize.height * 0.25,
                              autoplay: false,
                              viewportFraction: 0.8,
                              scale: 0.9,
                            ),
                          )
                  ],
                );
              })
        ],
      ),
    );
  }
}

class RegionListModel extends StatelessWidget {
  final Results regionModel;
  final int index;
  RegionListModel({this.regionModel, this.index});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final image = Image.asset(
      RegionMaps.mapList[index],
      width: _screenSize.width * 0.85 ,
      height: _screenSize.height *0.30,
      fit: BoxFit.fill,
    );
    return GestureDetector(
      child: Hero(
        child:  Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(children: <Widget>[
              ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: image),
              Center(
                child: Text(regionModel.name,style: TextStyle(color: Colors.amberAccent,fontSize: 35,fontFamily: 'Pokemon'),),
              )
            ])
          //
          //  child: Text(regionModel.name,style: TextStyle(color: Colors.white,fontSize: 18),),
        ),
        tag: 'Region-pokedex-transition-${regionModel.name}',
      ),
      onTap: () {
        navigateToPokedex(regionModel.name,index,context);
      /*  Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => RegionsPokeDex(regionModel.name,index)
          )
        );*/
      },
    );
  }

  void navigateToPokedex(String regionName, int index, BuildContext context){
    var blocProviderCardCreate = BlocProvider(
      bloc: PokeDexBloc(),
      child: RegionsPokeDex(regionName, index),
    );
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => blocProviderCardCreate));
  }
}
