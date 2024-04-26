import 'package:beyblade/accel.dart';
import 'package:beyblade/modelpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:o3d/o3d.dart';
import 'accel.dart';

class LUL extends StatelessWidget {
  const LUL({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          const SizedBox(child: O3D(disableZoom: true,disableTap: true,src: 'asset/a.glb',autoRotate: true,ar: false)),
          Padding(
            padding: const EdgeInsets.only(bottom: 70,left: 50),
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>AccelerometerExample()));},child: Text('Play',style: TextStyle(color: Colors.black,fontSize: 50),)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SizedBox(height: 100,width: 50,),
                              GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Call()));},child: Text('Stats',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 50),)),
                            ],
                          ),
                        ),
                      ],),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
