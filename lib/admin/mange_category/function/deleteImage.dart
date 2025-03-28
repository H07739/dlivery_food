import '../../../main.dart';

Future<bool> deleteImage(String url) async {
  try {
    // Check that the URL is not empty  
    if (url.isEmpty) return false;

   // Extract the image path from the URL  
    final Uri uri = Uri.parse(url);
    final List<String> segments = uri.pathSegments;
    if (segments.isEmpty) return false;

// Specify the image path in storage  
    final String imagePath = segments.sublist(segments.indexOf('image') + 1).join('/');

 // Delete the image from storage  
    await supabase.storage.from('image').remove([imagePath]);

    print('🗑️ Image deleted successfully   : $imagePath');
    return true;
  } catch (e) {
    print('❌   Error while deleting: $e');
    return false;
  }
}
