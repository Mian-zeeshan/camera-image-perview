import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';
class customprovider2 with ChangeNotifier{
 double _value = 1.0;
 List<int> _selecteditem=[];
 void removemyitem(int index)

   {
         _selecteditem.remove(index);
         notifyListeners();     
   }
  List<int>  get selecteditem => _selecteditem;

 void addindex(int index)

   {
         _selecteditem.add(index);
         notifyListeners();     
   }

 
  
  
 
List<Widget> _mediaList = [];
List<Widget> get mediaList => _mediaList;
void setmedialist(val){
  _mediaList.addAll(val);
  notifyListeners();
}

 
   List<Widget> _temp1 = [];
   List<Widget> get temp1 => _temp1;
   void settep1value (val){
          _temp1.addAll(val);
          notifyListeners();

   }
   void settep1val1 (val){
          _temp1.add(val);
          
          notifyListeners();

   }

   int?  _index ;
   int? get  index => _index; 
   void setindex(val){
    _index=val;
    notifyListeners();
   }
  
  List<Uint8List> _gallerydata = [];
  List<Uint8List> get gallerydata=> _gallerydata ;
  void setgallerydata(val)
  {
    _gallerydata.add(val);
    notifyListeners();
  }
   void setgallerydataa(val)
  {
    _gallerydata.addAll(val);
    notifyListeners();
  }
  List<Uint8List> _cimg=[];
  List<Uint8List> get cimg =>_cimg;
  void setcimg(Uint8List value){
    _cimg.add(value);
    notifyListeners();
  }
List<Uint8List> _cimg1=[];
  List<Uint8List> get cimg1 =>_cimg1;
  void setcimg1(Uint8List value){
    _cimg1.add(value);
    notifyListeners();
  }
  void setcimg1a( List<Uint8List> value){
    _cimg1.addAll(value);
    notifyListeners();
  }
  List<Uint8List> _tempimagesaver=[];
  List<Uint8List> get tempimagesaver =>_tempimagesaver;
  void settempimagesaver(List<Uint8List> value){
    _tempimagesaver.addAll(value);
    notifyListeners();
  }
  List<int> _countindex = [];
  List<int> get countindex => _countindex;
  void setcountindex(int val){
_countindex.add(val);
notifyListeners();

  } 
   void remcountindex(int val){
    int value = _countindex.indexOf(val);
_countindex.removeAt(value);
notifyListeners();

  } 



}
