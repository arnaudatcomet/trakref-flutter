import 'package:flutter/material.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class AssetResultWidget extends StatelessWidget {
  final List<Asset> assets;
  AssetResultWidget({this.assets});

  @override
  Widget build(BuildContext context) {
    return (assets == null) ? Container() : ListView.builder(
        itemCount: assets.length,
        itemBuilder: (context, index) {
          Asset asset = assets[index];
          return HomeCellWidget(
              line1: '${asset.serialNumber}',
              line2: '${asset.name}',
              line3: '${asset.assetStatus}',
              line4: '${asset.assetType}, ${asset.assetCategory}',
              cellType: (asset.isCylinder == true) ? HomeCellType.StickerCYLINDER : HomeCellType.Normal
          );
        }
    );
  }
}
