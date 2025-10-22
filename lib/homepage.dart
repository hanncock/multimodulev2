import 'package:flutter/material.dart';
import 'package:multimodule/reusables/Responsive/ResponsiveLayout.dart';
import 'package:multimodule/reusables/RoundedContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(),
          Expanded(child: Column(
            children: [
              SContainer(
                color: Colors.blue.withOpacity(0.2),
                height: 40,
              ),
              SizedBox(height: 10,),
              SContainer(
                width: double.infinity,
                height: 500,
                color: Colors.blue.withOpacity(0.2),
              ),
            ],
          ))
        ],
      ),
     /* body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
         child: SResponsiveLayout(),
        ),
      ),*/
    );
  }
}

class Dekstop extends StatelessWidget {
  const Dekstop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                child: SContainer(
                  height: 450,
                  color: Colors.blue.withOpacity(0.2),
                  child: Center(child: Text('Box 1'),),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    SContainer(
                      width: double.infinity,
                      height: 215,
                      color: Colors.yellow.withOpacity(0.2),
                      child: Center(child: Text('Box 2'),),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          child: SContainer(
                            height:190,
                            color: Colors.red.withOpacity(0.2),
                            child: Center(child: Text('Box 3'),),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Expanded(
                          child: SContainer(
                            height:190,
                          
                            color: Colors.red.withOpacity(0.2),
                            child: Center(child: Text('Box 4'),),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: SContainer(
                  height:190,
                  color: Colors.red.withOpacity(0.2),
                  child: Center(child: Text('Box 5'),),
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: SContainer(
                  height:190,
      
                  color: Colors.red.withOpacity(0.2),
                  child: Center(child: Text('Box 6'),),
                ),
              )
            ],
          )
        ],
        /*children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SContainer(
                  // width: double.infinity,
                  // height: double.maxFinite,
                  height: 450,
                  color: Colors.blue.withOpacity(0.2),
                  child: Center(child: Text("Box 1")),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                children: [
                  // SContainer(
                  //   width: double.infinity,
                  //   height: 215,
                  //   color: Colors.orange.withOpacity(0.2),
                  //   child: Center(child: Text("Box 2")),
                  // ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: SContainer(
                          height: 190,
                          width: double.infinity,
                          color: Colors.red.withOpacity(0.2),
                          child: Center(child: Text('Box 3'),),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: SContainer(
                          height: 190,
                          width: double.infinity,
                          color: Colors.green.withOpacity(0.2),
                          child: Center(child: Text('Box 4'),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 20,),
              SContainer(
                height: 190,
                width: double.infinity,
                color: Colors.red.withOpacity(0.2),
                child: Center(child: Text('Box 5'),),
              ),
      
      
            ],
          ),
          SizedBox(height: 20,),
          *//*Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SContainer(
                height: 190,
                width: double.infinity,
                color: Colors.red.withOpacity(0.2),
                child: Center(child: Text('Box 5'),),
              ),
              SizedBox(height: 20,),
              SContainer(
                height: 190,
                width: double.infinity,
                color: Colors.red.withOpacity(0.2),
                child: Center(child: Text('Box 6'),),
              ),
            ],
          )*//*
        ],*/
      ),
    );
  }
}
class Tablet extends StatelessWidget {
  const Tablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Expanded(
              child: SContainer(
                height: 450,
                color: Colors.blue.withOpacity(0.2),
                child: Center(child: Text('Box 1'),),
              ),
            ),
            SizedBox(width: 20,),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SContainer(
                    width: double.infinity,
                    height: 215,
                    color: Colors.yellow.withOpacity(0.2),
                    child: Center(child: Text('Box 2'),),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        child: SContainer(
                          height:190,
                          color: Colors.red.withOpacity(0.2),
                          child: Center(child: Text('Box 3'),),
                        ),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: SContainer(
                          height:190,

                          color: Colors.red.withOpacity(0.2),
                          child: Center(child: Text('Box 4'),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        SContainer(
          height:190,
          color: Colors.red.withOpacity(0.2),
          child: Center(child: Text('Box 5'),),
        ),
        SizedBox(height: 20,),
        SContainer(
          height:190,

          color: Colors.red.withOpacity(0.2),
          child: Center(child: Text('Box 6'),),
        )
      ],
    );
  }
}
class Mobile extends StatelessWidget {
  const Mobile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SContainer(
          height: 450,
          color: Colors.blue.withOpacity(0.2),
          child: Center(child: Text('Box 1'),),
        ),
        SizedBox(height: 20,),
        Column(
          children: [
            SContainer(
              width: double.infinity,
              height: 215,
              color: Colors.yellow.withOpacity(0.2),
              child: Center(child: Text('Box 2'),),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: SContainer(
                    height:190,
                    color: Colors.red.withOpacity(0.2),
                    child: Center(child: Text('Box 3'),),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: SContainer(
                    height:190,

                    color: Colors.red.withOpacity(0.2),
                    child: Center(child: Text('Box 4'),),
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 10,),
        SContainer(
          height:190,
          color: Colors.red.withOpacity(0.2),
          child: Center(child: Text('Box 5'),),
        ),
        SizedBox(height: 20,),
        SContainer(
          height:190,

          color: Colors.red.withOpacity(0.2),
          child: Center(child: Text('Box 6'),),
        )
      ],
    );
  }
}
