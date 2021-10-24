import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe_model.dart';
import '../controller/bookmark_controller.dart';

//TODO: GET ALL BOOKMARKED RECIPES
//TODO: DELETE RECIPE

class BookmarkView extends StatelessWidget {
  BookmarkView({ Key? key }) : super(key: key);

final BookmarkController bookmarkController = BookmarkController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmark'),
      ),
      body: FutureBuilder(
        future: bookmarkController.getBookmarkRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
          snapshot.data == null) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          List<RecipeModel> recipeModels = snapshot.data as List<RecipeModel>;
          return ListView.builder(
              itemCount: recipeModels.length,
              itemBuilder: (BuildContext context, int index) {
                RecipeModel recipeModel = recipeModels[index];

                return ListTile(
                  leading: Image.network(
                    recipeModel.image,
                    width: 150,
                    height: 150,
                  ),
                  title: Text(recipeModel.title),
                  subtitle: Text(recipeModel.category),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.redAccent[400],
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              content: const Text(
                                  "Are you sure you want to delete this recipe?"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      bookmarkController
                                          .removeBookmark(recipeModel.id!);

                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Recipe deleted")));
                                    },
                                    child: const Text("Yes"))
                              ],
                            ));
                  },
                );
              });
 
        }
      ),
      );
    
  }
}