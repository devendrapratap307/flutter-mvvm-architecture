import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invoice/data/response/status.dart';
import 'package:invoice/utils/routes/routes_name.dart';
import 'package:invoice/view_model/home_view_model.dart';
import 'package:invoice/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState

    homeViewViewModel.fetchPopulationList();
    homeViewViewModel.fetchJokeData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final userPreference = Provider.of<UserViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),
            actions: [
              InkWell(
                onTap: (){
                  userPreference.remove().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
                child: const Center(child: Text('Logout')),
              ),
            const SizedBox(width: 20,)]
        ),
        body: SafeArea(
          // child: ChangeNotifierProvider<HomeViewViewModel>(
          //   create: (BuildContext context)=> homeViewViewModel,
          //   child: Consumer<HomeViewViewModel>(
          //     builder: (context, value, _){
          //       switch(value.jokesData.status){
          //         case Status.LOADING:
          //           return const CircularProgressIndicator();
          //         case Status.ERROR:
          //           return Text(value.jokesData.message.toString());
          //         case Status.COMPLETED:
          //           return ListView.builder(
          //               itemCount: 1,
          //               itemBuilder: (context, index){
          //                 return Card(
          //                   child: ListTile(
          //                     title: Text(value.jokesData.data! as String),
          //                   ),
          //                 );
          //               });
          //       }
          //       return Container();
          //     },
          //   ),
          // )




          child: ChangeNotifierProvider<HomeViewViewModel>(
            create: (BuildContext context)=> homeViewViewModel,
            child: Consumer<HomeViewViewModel>(
              builder: (context, value, _){
                switch(value.populationData.status){
                  case Status.LOADING:
                    return const CircularProgressIndicator();
                  case Status.ERROR:
                    return Text(value.populationData.message.toString());
                  case Status.COMPLETED:
                    return ListView.builder(
                      itemCount: value.populationData.data!.data!.length,
                        itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.add_business),
                          title: Text(value.populationData.data!.data![index].nation as String),
                          trailing: Text(value.populationData.data!.data![index].year.toString()),  // right side
                          subtitle: Text(value.populationData.data!.data![index].population.toString()),
                          selected: true, // next  text and icon will be painted with the same color.
                        ),
                      );
                    });
                }
                return Container();
              },
            ),
          )
        )
    );
  }
}


