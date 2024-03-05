import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onusworks_albums_app/core/app_color.dart';
import 'package:onusworks_albums_app/core/app_style.dart';
import 'package:onusworks_albums_app/l10n/l10n.dart';
import 'package:onusworks_albums_app/src/album_photos/cubit/album_photos_cubit.dart';
import 'package:onusworks_albums_app/src/album_photos/state/album_photos_state.dart';

@RoutePage()
class AlbumPhotosPage extends StatelessWidget {
  final int albumId;

  AlbumPhotosPage({required this.albumId});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: AppBar(
        title: Text(
          l10n.albumPhotosTitle,
          style: AppStyle.appBarTitleStyle,
        ),
        backgroundColor: AppColor.appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15.0),
        child: BlocProvider(
          create: (context) => AlbumPhotosCubit()..fetchPhotos(albumId),
          child: BlocBuilder<AlbumPhotosCubit, AlbumPhotosState>(
            builder: (context, state) {
              if (state is AlbumPhotosLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: AppColor.appBarColor,
                ));
              } else if (state is AlbumPhotosLoaded) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemCount: state.photos.length,
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Column(
                        children: <Widget>[
                          //Caching for network images are pending
                          Image.network(state.photos[index].thumbnailUrl),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2.0, horizontal: 8.0),
                              child: Text(
                                state.photos[index].title,
                                style: AppStyle.bodyTextStyle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is AlbumPhotosError) {
                return Center(child: Text('Error: ${state.error}'));
              } else {
                return Center(child: Text(l10n.noPhotosFound));
              }
            },
          ),
        ),
      ),
    );
  }
}
