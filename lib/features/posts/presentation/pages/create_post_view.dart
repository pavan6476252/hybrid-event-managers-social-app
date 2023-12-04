import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hybrid/features/posts/domain/model/post_model.dart';
import 'package:hybrid/features/posts/presentation/bloc/post_creating/post_creating_bloc.dart';
import 'package:hybrid/utils/scaffold_sevices.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostView extends StatefulWidget {
  static String pathName = '/create-post';
  const CreatePostView({Key? key}) : super(key: key);

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  List<File> selectedImages = [];

  Future<void> pickImages(context) async {
    List<XFile> resultList = [];
    try {
      resultList = await ImagePicker().pickMultiImage();
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error while picking image"),
        ),
      );
    }

    setState(() {
      selectedImages.addAll(
        resultList
            .map((file) => File(file.path))
            .take(5 - selectedImages.length),
      );
    });
  }

  void removeImage(int index) {
    setState(() {
      selectedImages.removeAt(index);
    });
  }

  bool isBuySell = false;
  TextEditingController descriptionController = TextEditingController();

  List<ItemModel> itemsList = [];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final style = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
        actions: [_postUploadButton(context), SizedBox(width: 15)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    selectedImages.length + (selectedImages.length < 5 ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == selectedImages.length) {
                    return SizedBox(
                      width: 250,
                      child: AspectRatio(
                        aspectRatio: 18 / 9,
                        child: Card(
                          child: Center(
                            child: TextButton(
                              onPressed: () => pickImages(context),
                              child: const Text("Pick Image"),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SizedBox(
                    width: 250,
                    child: AspectRatio(
                      aspectRatio: 18 / 9,
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.file(
                                selectedImages[index],
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: IconButton(
                                  icon: CircleAvatar(
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: color.onPrimary,
                                      size: 30,
                                    ),
                                  ),
                                  onPressed: () => removeImage(index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                maxLines: 3,
                minLines: 1,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  hintText: 'Enter a description...',
                ),
                controller: descriptionController,
              ),
            ),
            const Divider(),
            SwitchListTile(
                title: const Text("Buy or Sell item"),
                value: isBuySell,
                onChanged: (val) => _toggleBuySell()),
            const Divider(),
            SizedBox(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ItemsList in post', style: style.titleMedium),
                      ],
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    // scrollDirection: Axis.horizontal,
                    itemCount:
                        itemsList.length + (itemsList.length < 5 ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == itemsList.length) {
                        return ElevatedButton.icon(
                            onPressed: () {
                              _showAddItemDialog(context: context);
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add Item"));
                      }
                      return ListTile(
                        onTap: () => _showOptionMenu(context, index),
                        title: Text(itemsList[index].name),
                        subtitle: Text(itemsList[index].name),
                        trailing: Text('Price: ${itemsList[index].price}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addItem(String name, String description, double price) {
    setState(() {
      itemsList
          .add(ItemModel(name: name, description: description, price: price));
    });
  }

  Future<void> _showOptionMenu(BuildContext context, int index) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                leading: const Icon(Icons.edit),
                title: const Text("Edit"),
                onTap: () async {
                  await _showAddItemDialog(
                    context: context,
                    name: itemsList[index].name,
                    description: itemsList[index].description,
                    price: itemsList[index].price,
                  );
                  Navigator.pop(context);
                }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("Remove"),
              onTap: () {
                _removeItemFromList(index);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void _toggleBuySell() {
    setState(() {
      isBuySell = !isBuySell;
    });
  }

  void _removeItemFromList(int index) {
    itemsList.removeAt(index);
    setState(() {});
  }

  Future<void> _showAddItemDialog(
      {required BuildContext context,
      String name = '',
      String description = '',
      double price = 0.0}) async {
    TextEditingController nameController = TextEditingController(text: name);
    TextEditingController priceController =
        TextEditingController(text: price.toString());
    TextEditingController descriptionController =
        TextEditingController(text: description);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                // onChanged: (value) => _name = value,
                controller: nameController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Description'),
                controller: descriptionController,
                // onChanged: (value) => _description = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                controller: priceController,
                // onChanged: (value) => _price = double.parse(value),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addItem(nameController.text, descriptionController.text,
                    double.parse(priceController.text));
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  _postUploadButton(BuildContext context) {
    return BlocConsumer<PostCreatingBloc, PostCreatingState>(
      listener: (context, state) {
        if (state is PostCreatingFailed) {
          log("error : ${state.failure.stackTrace}");
          ScaffoldMessageService.showScaffold(
              context: context, title: "Post creating failed", error: true);
        }
        if (state is PostCreatingSuccess) {
          ScaffoldMessageService.showScaffold(
            context: context,
            title: "Post uploaded Successfully",
          );
        }
      },
      builder: (context, state) {
        if (state is PostCreatingLoading) {
          return const SizedBox(
              height: 25, width: 25, child: CircularProgressIndicator());
        }
        return IconButton(
            onPressed: () {
              context.read<PostCreatingBloc>().add(PostThePostEvent(
                    isBuySell: isBuySell,
                    description: descriptionController.text,
                    images: selectedImages,
                    items: itemsList,
                  ));
            },
            icon: const Icon(
              Icons.send,
              color: Colors.black,
            ));
      },
    );
  }
}
