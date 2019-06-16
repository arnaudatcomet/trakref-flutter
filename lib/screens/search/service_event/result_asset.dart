import 'package:flutter/material.dart';
import 'package:trakref_app/models/asset.dart';
import 'package:trakref_app/widget/home_cell_widget.dart';

class AssetResultWidget extends StatefulWidget {
  final List<Asset> assets;
  Function assetSelectedHandle;
  AssetResultWidget({this.assets, this.assetSelectedHandle});

  @override
  _AssetResultWidgetState createState() => _AssetResultWidgetState();
}

class _AssetResultWidgetState extends State<AssetResultWidget>  with AutomaticKeepAliveClientMixin<AssetResultWidget>{
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return (widget.assets == null) ? Container() : ListView.builder(
        itemCount: widget.assets.length,
        itemBuilder: (context, index) {
          Asset asset = widget.assets[index];
          return GestureDetector(
            onTap: () {
              widget.assetSelectedHandle(asset);
            },
            child: HomeCellWidget(
                line1: '${asset.serialNumber ?? ""}',
                line2: '${asset.name ?? ""}',
//                line3: '${(asset.assetStatusID == 1) ? "Active" : "Inactive"}',
                line3: '${asset.location}',
                line4: '${asset.assetCategory ?? ""}',
                cellType: (asset.isCylinder == true) ? HomeCellType.StickerCYLINDER : HomeCellType.Normal
            ),
          );
        }
    );
  }
}