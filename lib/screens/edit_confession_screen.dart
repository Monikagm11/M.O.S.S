import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/confession.dart';
import '../providers/community_provider.dart';

class EditConfessionScreen extends StatefulWidget {
  static const routeName = '/edit-confession';

  @override
  State<EditConfessionScreen> createState() => _EditConfessionScreenState();
}

class _EditConfessionScreenState extends State<EditConfessionScreen> {
  //final _descriptionFocusNode = FocusNode();
  // final _imageUrlController = TextEditingController(); //control the image
  // final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedConfession = Confession(
    id: '',
    description: '',
    //imageUrl: '',
  );

  var _initValues = {
    'description': '',
    //'imageUrl': '',
  };

  var _isInit = true;

  var _isLoading = false;

  // @override
  // void initState() {
  //   _imageUrlFocusNode.addListener(
  //       _updateImageUrl); //don't wanna execute here, rather just wanna point it
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final confessionId = ModalRoute.of(context)!.settings.arguments;
      if (confessionId != null) {
        _editedConfession = Provider.of<Confessions>(context, listen: false)
            .findById(confessionId.toString());
        _initValues = {
          'description': _editedConfession.description,
          // 'imageUrl': '',
        };
        // _imageUrlController.text = _editedConfession.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // @override
  // void dispose() {
  //   _imageUrlFocusNode.removeListener(_updateImageUrl);
  //   _descriptionFocusNode.dispose();
  //   _imageUrlController.dispose();
  //   _imageUrlFocusNode.dispose();
  //   super.dispose();
  // }

  // void _updateImageUrl() {
  //   if (!_imageUrlFocusNode.hasFocus) {
  //     if ((!_imageUrlController.text.startsWith('http') &&
  //             !_imageUrlController.text.startsWith('https')) ||
  //         (!_imageUrlController.text.endsWith('.png') &&
  //             !_imageUrlController.text.endsWith('.jpg') &&
  //             !_imageUrlController.text.endsWith('.jpeg'))) {
  //       return;
  //     }
  //     setState(() {});
  //   }
  // }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedConfession.id != '') {
      await Provider.of<Confessions>(
        context,
        listen: false,
      ).updateConfession(_editedConfession.id, _editedConfession);
    } else {
      try {
        await Provider.of<Confessions>(context, listen: false)
            .addConfession(_editedConfession);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
    // print(_editedConfession.description);
    // print(_editedConfession.imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Confession'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          )
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    //DESCRIPTION
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      // focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return "Please enter a description";
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 character long.';
                        }
                        return null;
                      }),
                      onSaved: (value) {
                        _editedConfession = Confession(
                          description: value as String,
                          //imageUrl: _editedConfession.imageUrl,
                          id: _editedConfession.id,
                          isLiked: _editedConfession.isLiked,
                        );
                      },
                    ),

                    //ImageInput
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       width: 100,
                    //       height: 100,
                    //       margin: EdgeInsets.only(
                    //         top: 8,
                    //         right: 10,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 1,
                    //           color: Colors.grey,
                    //         ),
                    //       ),
                    //       child: _imageUrlController.text.isEmpty
                    //           ? Text('Enter a URL')
                    //           : FittedBox(
                    //               child: Image.network(
                    //                 _imageUrlController.text,
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //     ),
                    //     Expanded(
                    //       child: TextFormField(
                    //         decoration: InputDecoration(labelText: 'Image URL'),
                    //         keyboardType: TextInputType.url,
                    //         textInputAction: TextInputAction.done,
                    //         controller:
                    //             _imageUrlController, //Need to preview before the form is submitted
                    //         focusNode:
                    //             _imageUrlFocusNode, //When user unselected it it can change the UI and show the preview
                    //         onFieldSubmitted: (_) {
                    //           _saveForm();
                    //         },
                    //         validator: ((value) {
                    //           if (value!.isEmpty) {
                    //             return 'Please enter an image URL';
                    //           }
                    //           if (!value.startsWith('http') &&
                    //               !value.startsWith('https')) {
                    //             return 'Please enter a valid URL.';
                    //           }
                    //           // if (!value.endsWith('.png') &&
                    //           //     !value.endsWith('.jpg') &&
                    //           //     !value.endsWith('.jpeg')) {
                    //           //   return 'Please enter a valid image URL.';
                    //           // }
                    //           return null;
                    //         }),
                    //         onSaved: (value) {
                    //           _editedConfession = Confession(
                    //             description: _editedConfession.description,
                    //             imageUrl: value as String,
                    //             id: _editedConfession.id,
                    //             isLiked: _editedConfession.isLiked,
                    //           );
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
