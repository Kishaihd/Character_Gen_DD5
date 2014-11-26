Polymer Dart Template (Simple)
======
*Tested with Polymer version:* 0.15.1+3

1. Create a new folder for your app in your Dart projects folder using Windows Explorer or Mac Finder.
2. Copy the contents of the `Polymer_Template_Simple` folder into your new app folder.
3. Using the Dart Editor, select `File->Open Existing Folder...` (or use `Ctrl+O`).
4. Select your new app folder to import the project into the Editor.
5. The Dart Editor should do this automatically, but if not, in the Dart Editor's Files panel, right-click the new project's `pubspec.yaml` file and select `Pub Get` to install all needed dependencies.
6. If your project shows errors at this point, select the root of your project in the Dart Editor's Files panel and select `Tools->Reanalyze Sources` (or use `Ctrl+Alt+Shift+B`).

*REMINDER -- Update your app name:* Take a moment now to edit your `pubspec.yaml` metadata, global.dart, and `README.md` files with your actual app's name. Note that when you change the app name in `pubspec.yaml`, you will need to update the `<app-view>` HTML import path in `index.html` with the new name. 
