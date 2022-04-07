import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:food_recipe/index.dart';

class UpdateBakedItemImage extends StatefulWidget {
  final String image;
  const UpdateBakedItemImage({Key? key, required this.image}) : super(key: key);

  @override
  State<UpdateBakedItemImage> createState() => _UpdateBakedItemImageState();
}

class _UpdateBakedItemImageState extends State<UpdateBakedItemImage> {
  XFile? _imageFile;
  dynamic _pickImageError;
  String? _retrieveDataError;
  String? _extImage;

  final ImagePicker _picker = ImagePicker();

  void _onImageButtonPressed(ImageSource source,
      {required BuildContext context, maxWidth, maxHeight}) async {
    // final addMdl = Provider.of<AddMealProvider>(context, listen: false);
    final updateMdl =
        Provider.of<UpdateBakeItemProvider>(context, listen: false);
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: maxWidth,
        maxHeight: maxHeight,
        imageQuality: 100,
      );
      setState(() {
        _imageFile = pickedFile!;
        updateMdl.pickMealImage(File(_imageFile!.path));
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage({h, w}) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile!.path);
      } else {
        // return Image.file(File(_imageFile.path));
        return SizedBox(
            height: h / 3.5,
            width: w,
            child: InkWell(
                onTap: () {
                  _onImageButtonPressed(ImageSource.gallery,
                      context: context, maxHeight: h / 3.5, maxWidth: w);
                },
                child: Image.file(File(_imageFile!.path), fit: BoxFit.cover)));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return imagePlaceHolder(h: h, w: w);
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file!;
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Widget imagePlaceHolder({h, w}) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: h / 3.5,
      width: w,
      color: kPurple4,
      child: InkWell(
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery,
              context: context, maxHeight: h / 3.5, maxWidth: w);
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 80,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _extImage = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    if (_extImage != null) {
      return Center(
        child: Image.network(_extImage!),
      );
    } else {
      return Center(
        child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
            ? FutureBuilder<void>(
                future: retrieveLostData(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return imagePlaceHolder(h: h, w: w);
                    case ConnectionState.done:
                      return _previewImage(h: h, w: w);
                    default:
                      if (snapshot.hasError) {
                        return Text(
                          'Pick image error: ${snapshot.error}}',
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return imagePlaceHolder(h: h, w: w);
                      }
                  }
                },
              )
            : _previewImage(h: h, w: w),
      );
    }
  }
}

typedef OnPickImageCallback = void Function(
    double maxWidth, double maxHeight, int quality);
