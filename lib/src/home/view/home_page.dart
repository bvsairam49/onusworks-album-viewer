import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/core/app_color.dart';
import 'package:onusworks_albums_app/core/app_style.dart';
import 'package:onusworks_albums_app/l10n/l10n.dart';
import 'package:onusworks_albums_app/router/app_router.gr.dart';
import 'package:onusworks_albums_app/src/home/cubit/home_cubit.dart';
import 'package:onusworks_albums_app/src/home/state/home_state.dart';
import 'package:onusworks_albums_app/src/presentation/widgets/list_item_with_fav_button_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String _newAlbumTitle = '';
  String _newId = '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.homeScreenTitle,
          style: AppStyle.appBarTitleStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Logic for logout
              // You can use Navigator.push to navigate to the Login screen
              BlocProvider.of<HomeCubit>(context).logoutUser();
              //navigate to login screen
              context.router.replace(const LoginRoute());
            },
          ),
        ],
        backgroundColor: AppColor.appBarColor,
      ),
      backgroundColor: AppColor.appBackgroundColor,
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.appBarColor,
              ),
            );
          } else if (state is HomeLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.albums,
                    style: AppStyle.headerTextStyle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.albums.length,
                    padding: const EdgeInsets.only(bottom: 40.0),
                    itemBuilder: (context, index) {
                      return ListItemWithFavButtonCard(
                          album: state.albums[index],
                          isFavorite: state.albums[index].isFavorite,
                          onPressed: () {
                            // Navigate to Album Photos screen
                            // You can use Navigator.push to navigate to the Album Photos screen
                            context.router.push(AlbumPhotosRoute(
                                albumId: state.albums[index].id));
                          },
                          onDeleteItem: () {
                            BlocProvider.of<HomeCubit>(context).deleteAlbum(
                              state.albums[index].id,
                              state.albums,
                            );
                          },
                          onFavoriteSelected: () {
                            setState(() {
                              state.albums[index].isFavorite =
                                  !state.albums[index].isFavorite;
                            });
                          });
                    },
                  ),
                ),
              ],
            );
          } else if (state is HomeDeleted) {
            //Below code is replicating the logic of HomeLoaded due to lack of time not able to refactor
            //This state need to be simplified and use common widget for list view
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    l10n.albums,
                    style: AppStyle.headerTextStyle,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.albums.length,
                    padding: const EdgeInsets.only(bottom: 40.0),
                    itemBuilder: (context, index) {
                      return ListItemWithFavButtonCard(
                          album: state.albums[index],
                          isFavorite: state.albums[index].isFavorite,
                          onPressed: () {
                            // Navigate to Album Photos screen
                            // You can use Navigator.push to navigate to the Album Photos screen
                            context.router.push(AlbumPhotosRoute(
                                albumId: state.albums[index].id));
                          },
                          onDeleteItem: () {
                            BlocProvider.of<HomeCubit>(context).deleteAlbum(
                              state.albums[index].id,
                              state.albums,
                            );
                          },
                          onFavoriteSelected: () {
                            setState(() {
                              state.albums[index].isFavorite =
                                  !state.albums[index].isFavorite;
                            });
                          });
                    },
                  ),
                ),
              ],
            );
          } else if (state is HomeError) {
            return Center(
              child: Text(
                state.message,
                style: AppStyle.headerTextStyle,
              ),
            );
          } else {
            return Center(
                child: Text(
              l10n.failedToFetchAlbums,
              style: AppStyle.headerTextStyle,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showAddAlbumDialog(context);
          bool isNewAlbumAdded = await BlocProvider.of<HomeCubit>(context)
              .addNewAlbum(_newId, _newAlbumTitle);

          if (isNewAlbumAdded) {
            await BlocProvider.of<HomeCubit>(context).fetchAlbums();
          }
        },
        backgroundColor: AppColor.appBarColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddAlbumDialog(BuildContext context) {
    final l10n = context.l10n;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            l10n.addNewAlbum,
            style: AppStyle.headerTextStyle,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: l10n.title),
                onChanged: (value) {
                  setState(() {
                    _newAlbumTitle = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Id'),
                onChanged: (value) {
                  setState(() {
                    _newId = value;
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(l10n.cancel),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text(l10n.addAlbum),
            ),
          ],
        );
      },
    );
  }
}
