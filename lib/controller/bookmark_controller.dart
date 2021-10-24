import 'package:flutter/cupertino.dart';
import 'package:recipe_app/model/recipe_model.dart';
import 'package:recipe_app/service/bookmark_recipe.dart';

class BookmarkController with ChangeNotifier {
  String _errorMessage = "";

  get erroMessage => _errorMessage;

  setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  BookmarkService bookmarkService = BookmarkService();

  Future<List<RecipeModel>> getBookmarkRecipes() async {
    try {
      await bookmarkService.open();
      var bookMarkData = await bookmarkService.getAllRecipe();
      if (bookMarkData != null) {
        await bookmarkService.close();
        return bookMarkData;
      }
    } catch (error) {
      setErrorMessage("$error");
    }
    await bookmarkService.close();
    return [];
  }

  addBookmark(RecipeModel recipeModel) async {
    try {
      await bookmarkService.open();
      bookmarkService.insert(recipeModel);
      await getBookmarkRecipes();
      await bookmarkService.close();
    } catch (error) {
      setErrorMessage("$error");
    }
  }

  void removeBookmark(int id) async {
    try {
      await bookmarkService.open();
      bookmarkService.delete(id);
      await getBookmarkRecipes();
      await bookmarkService.close();
    } catch (error) {
      setErrorMessage("$error");
    }
  }
}
