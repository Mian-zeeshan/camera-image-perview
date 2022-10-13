import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:photo_manager/photo_manager.dart';

import 'image provider/image_provider.dart';
class mycamera4 extends StatefulWidget {
  const mycamera4({ Key? key }) : super(key: key);

  @override
  State<mycamera4> createState() => _mycamera4State();
}

class _mycamera4State extends State<mycamera4> {
  late List<CameraDescription> cameras;
   CameraController? cameraController;
  //List<XFile> myimagelist=[];
  @override
  void initState() {
    // TODO: implement initState
    
    startCamera();
     _fetchNewMedia();
    
    
    super.initState();
  }
  /**TODO
   * Start Camera Function 
   */
  void startCamera()async{
    cameras=await availableCameras();
  cameraController = CameraController(
    cameras[0],
  ResolutionPreset.high,
  enableAudio: false
  );
    await cameraController?.initialize().then((value){
      if(!mounted){
        return;
      }
      setState(() {
        
      });
    }).catchError((e){
      debugPrint(e);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    cameraController?.dispose();
    super.dispose();
  }


   ScrollController _scrollController = ScrollController();

  int currentPage = 0;
  int? lastPage;
  
/*-
TODO:
-------galleryimage show function*/

  /* This is function to load gallery images into list */
  
  _fetchNewMedia() async {
    SizeConstraint szc = SizeConstraint(
  minWidth: 0,
  maxWidth: 100,
  minHeight: 0,
  maxHeight: 100,
  ignoreSize: false,
);
    final option = FilterOption(
  sizeConstraint: szc,
);

FilterOptionGroup filter = new FilterOptionGroup();
filter.setOption( AssetType.video , option );
     final customprovider = Provider.of<customprovider2>(
    
      context,listen: false);
    lastPage = currentPage;
    final PermissionState _ps = await PhotoManager.requestPermissionExtend();
    if (_ps.isAuth) {
      // success
//load the album list
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(
             type: RequestType.image,
            filterOption: filter,
      onlyAll: true);
       
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage); //preloading files
      print(media);
/**this for loop store widget in in list of widget */

       File? file;
        XFile mfile;
     /* same images into myimagelist  and convert asset entity into xfile */
       for(int i = 0; i<= media.length;i++){
         file = await media[i].file;
         mfile  = XFile(file!.path);
           Uint8List data =File(mfile.path).readAsBytesSync() ;
           customprovider.setgallerydata(data);
       
      }
        
    
     
    } else {
      // fail
      PhotoManager.openSetting();
      }
  }
  /*-----------gallery show image function*/
  
  
  @override
  
  Widget build(BuildContext context) {
   
     final customprovider = Provider.of<customprovider2>(context,listen: false);
      
    Size size = MediaQuery.of(context).size;
    
    if(cameraController!=null&&cameraController!.value.isInitialized){
      return Scaffold(
       
        body: Stack(
           fit: StackFit.loose,
  // overflow: Overflow.visible,
  clipBehavior: Clip.hardEdge,
        //fit: StackFit.expand,
        
          children: [
             Positioned(
              top: 0,
              left: 0,
               child: Container(
                width: size.width,
                height: size.height,
                child: CameraPreview(cameraController!)),
             ),
            
             Positioned(
          bottom: 0,
          left: 0,
            child: Container(
              height: 70,
              width: size.width,
              
              child: Stack(
                children: [
                  CustomPaint(painter:ourpainter(),
                size: Size(size.width,70), ),
                 Center(
          heightFactor: 0.6,
          child:FloatingActionButton(
            
            onPressed: () async{
              
             /*XFile image= await */
           await  cameraController?.takePicture().then((image){
                    Uint8List data =File(image.path).readAsBytesSync() ;
                    customprovider.setcimg(data);
                    
                    
            
             });

             /**TODO  swapping the Gallery Images unit8list List   */
             if(customprovider.cimg.length==1){
              
                        customprovider.setcimg1(customprovider.cimg[0]);
                         customprovider.setcimg1a(customprovider.gallerydata);
                         customprovider.settempimagesaver(customprovider.gallerydata);
                        customprovider.gallerydata.clear();
                         customprovider.setgallerydataa(customprovider.cimg1);
                       // customprovider.setgallerydataa(customprovider.cimg1);
                        customprovider.cimg1.clear();
                       
                    }
                    else{
                         customprovider.gallerydata.clear();
                       customprovider.cimg1.clear();         
                  
                      customprovider.setcimg1a(List.from((customprovider.cimg).reversed));
                      customprovider.setcimg1a(customprovider.tempimagesaver);
                       customprovider.gallerydata.clear();
                      customprovider.setgallerydataa(customprovider.cimg1);

                    }
            
            
          },
          backgroundColor: Colors.orange ,
          child: Icon(Icons.add_a_photo),
          ),
        ),
        Container(
          height: 80,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: IconButton(onPressed: () {
                 
               }, icon: Icon(Icons.home,color: Colors.orange,)),
             ),
             IconButton(onPressed: () {
               
             }, icon: Icon(Icons.restaurant_menu,color: Colors.orange,),),
             SizedBox(width: size.width*0.20,),
             IconButton(onPressed: () {
               
             },
              icon: Icon(Icons.bookmark,color: Colors.orange,)),
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: IconButton(onPressed: () {
                 
               }, icon: Icon(Icons.notifications,color: Colors.orange,)),
             ),
            ],
          ),
        ),
        
       
                ],
                 
              ),
            ),
          ),

            Positioned(top: 437,
        left: 5,
         right: 0, 
        // bottom: 0,
        child:  Consumer<customprovider2>(builder: ((context, value, child) {
         
            return  Container(
            height: 130,
            child: Container(
            
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                 reverse: false,
                 controller: _scrollController,
                  itemCount: value.gallerydata.length,
                 
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: () {
                       if(value.countindex.contains(index)){
               value.remcountindex(index);
                       }
                       else {

value.setcountindex(index);

                       }
                    
                 debugPrint(value.countindex.toString());
                       
                      },
                      child:Stack(

  children: [
    
    Container(
  
                    width: 100,
  
                    height: 100,
  
                    child: Stack(
  
                      children: <Widget>[
  
                        Positioned.fill(
  
                          child: Image.memory(
                            
  
                            value.gallerydata[index],
  
                            fit: BoxFit.cover,
                            cacheHeight: 100,
                            cacheWidth: 100,
  
                          ),
  
                        ),
  
                       
                      ],
  
                    ),
  
                  ),
                 if(value.countindex.contains(index))
                  Positioned(
                    top: 10,
                    right: 0,
                    child:  Icon(Icons.check_box,color: Colors.green,size: 40,))
                  
                  ]


    ));
                  },
                  
                   separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 15,),),
            ),
          );
           
          })),
            // Consumer(
              
            // ),
        ),

        /**TODO this widget use for count selected images for send to server */
        Consumer<customprovider2>(builder: ((context, value, child) {
          
return customprovider.countindex.length!=0
 ?Positioned(
          top: 407,
          right: 0,
          child:Container(
        height: 46.0,
        width: 46.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 SizedBox(
                  height: 10,
                ),
                Icon(Icons.check),
                // SizedBox(
                //   height: 5,
                // ),
                 
                SizedBox(
                  child: Text(value.countindex.length.toString()))
              ],
            ),
            onPressed: () {}),
        ),
      ), ):Container();
        }))
       
 
          ],
        ),

      );
    }else {
      return SizedBox();
    }
  }
}


/**TODO Painter class used for bottom Navigation Bar */

class ourpainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    var path=Path();
    paint.color=Colors.blue;
    // path.moveTo(0, 0);
    // path.quadraticBezierTo(x1, y1, x2, y2)
    path.moveTo(0, size.height*0.48);
    path.quadraticBezierTo(size.width*0.40, 0, size.width*0.40, 20);
    path.arcToPoint(Offset(size.width*0.60, 20),radius: Radius.circular(10.0),clockwise: false);
      path.quadraticBezierTo(size.width*0.60, 0, size.width, size.height*0.48 );
// path.quadraticBezierTo(size.width*0.5,0, size.width, 300);
//  path.lineTo(size.width, 0);
//  path.lineTo(0, 0);
path.lineTo(size.width, size.height);
path.lineTo(0, size.height);


  // path.lineTo(size.width, size.height);
  //   path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }

  
}