import 'package:flutter/material.dart';


//4.5 流式布局


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '流式布局'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Wrap(
              spacing: 8.0, //主轴(水平)方向间距
              runSpacing: 4.0, //纵轴（垂直）方向间距
              alignment: WrapAlignment.center,////沿主轴方向居中
              children: [
                Chip(
                    label: Text("纵昂"),
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A'),),
                ),
                Chip(
                    label: Text("我打野最6"),
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M'),),
                ),
                Chip(
                  label: Text("我选辅助钟馗"),
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H'),),
                ),
                Chip(
                  avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
                  label: Text('乐刻运动健身'),
                ),
              ],
            ),

          /** 4.5.2 Flow
           * 我们一般很少会使用Flow，因为其过于复杂，需要自己实现子 widget 的位置转换，在很多场景下首先要考虑的是Wrap是否满足需求。
           * Flow主要用于一些需要自定义布局策略或性能要求较高(如动画中)的场景。Flow有如下优点：
           * 1、性能好;Flow是一个对子组件尺寸以及位置调整非常高效的控件,Flow用转换矩阵在对子组件进行位置调整的时候进行了优化:
           * 在Flow定位过后,如果子组件的尺寸或者位置发生了变化,在FlowDelegate中的paintChildren()方法中调用context.paintChild进行重绘
           * 而context.paintChild在重绘时使用了转换矩阵，并没有实际调整组件位置。
           *
           * 2、灵活;由于我们需要自己实现FlowDelegate的paintChildren()方法，所以我们需要自己计算每一个组件的位置，因此，可以自定义布局策略。
           *
           * 缺点：
           * 1、使用复杂。
           * 2、Flow 不能自适应子组件大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。
           *
           * */
            Flow(
              delegate: TestFlowDelegate(margin: EdgeInsets.all(10.0)),
              children: <Widget>[
                Container(width: 80.0, height:80.0, color: Colors.red,),
                Container(width: 80.0, height:80.0, color: Colors.green,),
                Container(width: 80.0, height:80.0, color: Colors.blue,),
                Container(width: 80.0, height:80.0,  color: Colors.yellow,),
                Container(width: 80.0, height:80.0, color: Colors.brown,),
                Container(width: 80.0, height:80.0,  color: Colors.purple,),
              ],
            )
          ],
        ),
      ),
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

//实现TestFlowDelegate:
class TestFlowDelegate extends FlowDelegate {
  EdgeInsets margin;

  TestFlowDelegate({this.margin = EdgeInsets.zero});

  double width = 0;
  double height = 0;

  @override
  void paintChildren(FlowPaintingContext context) {
    /**
     * 可以看到我们主要的任务就是实现paintChildren，它的主要任务是确定每个子widget位置。
     * 由于Flow不能自适应子widget的大小，我们通过在getSize返回一个固定大小来指定Flow的大小。
     * */
    var x = margin.left;
    var y = margin.top;
    //计算每一个子widget的位置
    for (int i = 0; i < context.childCount; i++) {
      var w = context.getChildSize(i)!.width + x + margin.right;
      if (w < context.size.width) {
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x = w + margin.left;
      } else {
        x = margin.left;
        y += context.getChildSize(i)!.height + margin.top + margin.bottom;
        //绘制子widget(有优化)
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0.0));
        x += context.getChildSize(i)!.width + margin.left + margin.right;
      }
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // 指定Flow的大小，简单起见我们让宽度竟可能大，但高度指定为200，
    // 实际开发中我们需要根据子元素所占用的具体宽高来设置Flow大小
    return Size(double.infinity, 200.0);
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) {
    return oldDelegate != this;
  }
}