import '../../../main.dart';

Future<bool> deleteImage(String url) async {
  try {
    // التحقق من أن الرابط ليس فارغًا
    if (url.isEmpty) return false;

    // استخراج مسار الصورة من الرابط
    final Uri uri = Uri.parse(url);
    final List<String> segments = uri.pathSegments;
    if (segments.isEmpty) return false;

    // تحديد مسار الصورة داخل التخزين
    final String imagePath = segments.sublist(segments.indexOf('image') + 1).join('/');

    // حذف الصورة من التخزين
    await supabase.storage.from('image').remove([imagePath]);

    print('🗑️ تم حذف الصورة بنجاح: $imagePath');
    return true;
  } catch (e) {
    print('❌ خطأ أثناء الحذف: $e');
    return false;
  }
}
