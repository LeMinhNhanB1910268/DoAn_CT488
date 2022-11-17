// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../models/book.dart';
// // import '../shared/dialog_utils.dart';

// import 'books_manager.dart';

// class EditBookScreen extends StatefulWidget {
//   static const routeName = '/edit-book';

//   EditBookScreen(
//     Book? book, {
//     super.key,
//   }) {
//     if (book == null) {
//       this.book = Book(
//         id: null,
//         title: '',
//         volumnCount: 0,
//         description: '',
//         imageUrl: '',
//       );
//     } else {
//       this.book = book;
//     }
//   }

//   late final Book book;

//   @override
//   State<EditBookScreen> createState() => _EditBookScreenState();
// }

// class _EditBookScreenState extends State<EditBookScreen> {
//   final _imageUrlController = TextEditingController();
//   final _imageUrlFocusNode = FocusNode();
//   final _editForm = GlobalKey<FormState>();
//   late Book _editedBook;
//   var _isLoading = false;

//   bool _isValidImageUrl(String value) {
//     return (value.startsWith('http') || value.startsWith('https')) &&
//         (value.endsWith('.png') ||
//             value.endsWith('.jpg') ||
//             value.endsWith('.jpeg'));
//   }

//   @override
//   void initState() {
//     _imageUrlFocusNode.addListener(() {
//       if (!_imageUrlFocusNode.hasFocus) {
//         if (!_isValidImageUrl(_imageUrlController.text)) {
//           return;
//         }
//         // Anh hop le -> Ve lai man hinh de hien preview
//         setState(() {});
//       }
//     });
//     _editedBook = widget.book;
//     _imageUrlController.text = _editedBook.imageUrl;
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _imageUrlController.dispose();
//     _imageUrlFocusNode.dispose();
//     super.dispose();
//   }

//   Future<void> _saveForm() async {
//     final isValid = _editForm.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _editForm.currentState!.save();

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       final booksManager = context.read<BooksManager>();
//       if (_editedBook.id != null) {
//         await booksManager.updateBook(_editedBook);
//       } else {
//         await booksManager.addBook(_editedBook);
//       }
//     } catch (error) {
//       await showErrorDialog(context, 'Something went wrong.');
//     }

//     setState(() {
//       _isLoading = false;
//     });

//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//   }

//   Future<void> showErrorDialog(BuildContext context, String message) {
//     return showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         title: const Text('An Error Occurred!'),
//         content: Text(message),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Okay'),
//             onPressed: () {
//               Navigator.of(ctx).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Text Book'),
//         actions: <Widget>[
//           IconButton(
//             icon: const Icon(Icons.save),
//             onPressed: _saveForm,
//           ),
//         ],
//       ),
//       body: _isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _editForm,
//                 child: ListView(
//                   children: <Widget>[
//                     buildTitleField(),
//                     buildVolumnCountField(),
//                     buildDescriptionField(),
//                     buildBookPreview(),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   TextFormField buildTitleField() {
//     return TextFormField(
//       initialValue: _editedBook.title,
//       decoration: const InputDecoration(labelText: 'Title'),
//       textInputAction: TextInputAction.next,
//       autofocus: true,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please provide a value.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _editedBook = _editedBook.copyWith(title: value);
//       },
//     );
//   }

//   TextFormField buildVolumnCountField() {
//     return TextFormField(
//       initialValue: _editedBook.volumnCount.toString(),
//       decoration: const InputDecoration(labelText: 'Number of pages'),
//       textInputAction: TextInputAction.next,
//       keyboardType: TextInputType.number,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter a volumnCount.';
//         }
//         if (double.tryParse(value) == null) {
//           return 'Please enter a valid number.';
//         }
//         if (double.parse(value) <= 0) {
//           return 'Please enter a number greater than zero.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _editedBook = _editedBook.copyWith(volumnCount: int.parse(value!));
//       },
//     );
//   }

//   TextFormField buildDescriptionField() {
//     return TextFormField(
//       initialValue: _editedBook.description,
//       decoration: const InputDecoration(labelText: 'Description'),
//       maxLines: 3,
//       keyboardType: TextInputType.multiline,
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter a description.';
//         }
//         if (value.length < 10) {
//           return 'Should be at least 10 characters long.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _editedBook = _editedBook.copyWith(description: value);
//       },
//     );
//   }

//   Widget buildBookPreview() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: <Widget>[
//         Container(
//           width: 100,
//           height: 100,
//           margin: const EdgeInsets.only(
//             top: 8,
//             right: 10,
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(
//               width: 1,
//               color: Colors.grey,
//             ),
//           ),
//           child: _imageUrlController.text.isEmpty
//               ? const Text('Enter a URL')
//               : FittedBox(
//                   child: Image.network(
//                     _imageUrlController.text,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//         ),
//         Expanded(
//           child: buildImageURLField(),
//         ),
//       ],
//     );
//   }

//   TextFormField buildImageURLField() {
//     return TextFormField(
//       decoration: const InputDecoration(labelText: 'Image URL'),
//       keyboardType: TextInputType.url,
//       textInputAction: TextInputAction.done,
//       controller: _imageUrlController,
//       focusNode: _imageUrlFocusNode,
//       onFieldSubmitted: (value) => _saveForm(),
//       validator: (value) {
//         if (value!.isEmpty) {
//           return 'Please enter an image URL.';
//         }
//         if (!_isValidImageUrl(value)) {
//           return 'Please enter a valid image URL.';
//         }
//         return null;
//       },
//       onSaved: (value) {
//         _editedBook = _editedBook.copyWith(imageUrl: value);
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/book.dart';
// import '../shared/dialog_utils.dart';

import 'books_manager.dart';

class EditBookScreen extends StatefulWidget {
  static const routeName = '/edit-book';

  EditBookScreen(
    Book? book, {
    super.key,
  }) {
    if (book == null) {
      this.book = Book(
        id: null,
        title: '',
        volumnCount: 0,
        description: '',
        description1: '',
        imageUrl: '',
        imageUrl1: '',
        genres: '',
        author: '',
      );
    } else {
      this.book = book;
    }
  }

  late final Book book;

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrl1Controller = TextEditingController();
  final _imageUrl1FocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Book _editedBook;
  var _isLoading = false;

  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        // Anh hop le -> Ve lai man hinh de hien preview
        setState(() {});
      }
    });
    _editedBook = widget.book;
    _imageUrlController.text = _editedBook.imageUrl;
    super.initState();
  }

  @override
  void initState1() {
    _imageUrl1FocusNode.addListener(() {
      if (!_imageUrl1FocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrl1Controller.text)) {
          return;
        }
        // Anh hop le -> Ve lai man hinh de hien preview
        setState(() {});
      }
    });
    _editedBook = widget.book;
    _imageUrl1Controller.text = _editedBook.imageUrl1;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void dispose1() {
    _imageUrl1Controller.dispose();
    _imageUrl1FocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      final booksManager = context.read<BooksManager>();
      if (_editedBook.id != null) {
        await booksManager.updateBook(_editedBook);
      } else {
        await booksManager.addBook(_editedBook);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong.');
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Book'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildTitleField(),
                    buildVolumnCountField(),
                    buildDescriptionField(),
                    buildDescription1Field(),
                    buildBookPreview(),
                    buildBookPreview1(),
                    buildBookGenres(),
                    buildBookAuthor(),
                  ],
                ),
              ),
            ),
    );
  }

  TextFormField buildTitleField() {
    return TextFormField(
      initialValue: _editedBook.title,
      decoration: const InputDecoration(labelText: 'Title'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(title: value);
      },
    );
  }

  TextFormField buildBookGenres() {
    return TextFormField(
      initialValue: _editedBook.genres,
      decoration: const InputDecoration(labelText: 'Genres'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(genres: value);
      },
    );
  }

  TextFormField buildVolumnCountField() {
    return TextFormField(
      initialValue: _editedBook.volumnCount.toString(),
      decoration: const InputDecoration(labelText: 'Number of pages'),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a volumnCount.';
        }
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number.';
        }
        if (double.parse(value) <= 0) {
          return 'Please enter a number greater than zero.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(volumnCount: int.parse(value!));
      },
    );
  }

  TextFormField buildDescriptionField() {
    return TextFormField(
      initialValue: _editedBook.description,
      decoration: const InputDecoration(labelText: 'Description top'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(description: value);
      },
    );
  }

  TextFormField buildDescription1Field() {
    return TextFormField(
      initialValue: _editedBook.description1,
      decoration: const InputDecoration(labelText: 'Description bottom'),
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a description.';
        }
        if (value.length < 10) {
          return 'Should be at least 10 characters long.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(description1: value);
      },
    );
  }

  Widget buildBookPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  Widget buildBookPreview1() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrl1Controller.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrl1Controller.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURL1Field(),
        ),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(imageUrl: value);
      },
    );
  }

  TextFormField buildImageURL1Field() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrl1Controller,
      focusNode: _imageUrl1FocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL.';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(imageUrl1: value);
      },
    );
  }

  TextFormField buildBookAuthor() {
    return TextFormField(
      initialValue: _editedBook.author,
      decoration: const InputDecoration(labelText: 'Author'),
      textInputAction: TextInputAction.next,
      autofocus: true,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please provide a value.';
        }
        return null;
      },
      onSaved: (value) {
        _editedBook = _editedBook.copyWith(author: value);
      },
    );
  }
}
