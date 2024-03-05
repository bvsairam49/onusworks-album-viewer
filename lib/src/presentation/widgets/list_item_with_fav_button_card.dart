import 'package:flutter/material.dart';
import 'package:onusworks_albums_app/core/app_style.dart';
import 'package:onusworks_albums_app/src/data/album_model.dart';

class ListItemWithFavButtonCard extends StatelessWidget {
  final Album album;
  final VoidCallback onPressed;
  final bool isFavorite;
  final VoidCallback onDeleteItem;
  final VoidCallback onFavoriteSelected;

  const ListItemWithFavButtonCard(
      {required this.album,
      required this.onPressed,
      required this.onDeleteItem,
      required this.onFavoriteSelected,
      this.isFavorite = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(album.id),
      onDismissed: (_) => onDeleteItem(),
      background: Container(
        color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      ),
      child: Card(
        color: Colors.grey.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(
            color: Colors.grey.shade300,
            width: 1.0,
          ),
        ),
        elevation: 1,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: ListTile(
          title: Text(
            album.title,
            style: AppStyle.bodyTextStyle,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'ID: ${album.id}',
              ),
              IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.favorite_sharp
                      : Icons.favorite_border_sharp,
                ),
                onPressed: onFavoriteSelected,
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(left: 15.0, right: 5.0),
          onTap: onPressed,
        ),
      ),
    );
  }
}
