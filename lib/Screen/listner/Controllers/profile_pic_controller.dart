import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class StudentProfileController extends GetxController{

  Rx<String> imageUrl = ''.obs;
  ImagePicker imagePicker = ImagePicker();
  Future uploadImg() async {

    final img = await imagePicker.pickImage(source: ImageSource.gallery);
    if(img!= null){
      imageUrl.value = img.path.toString();
    }

  }

}