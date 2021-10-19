//4.5.1 Wrap

/**
 * 下面是Wrap的定义:
 * Wrap({
    ...
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runAlignment = WrapAlignment.start,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    List<Widget> children = const <Widget>[],
    })

 * 我们可以看到Wrap的很多属性在Row（包括Flex和Column）中也有,如direction、crossAxisAlignment、textDirection、verticalDirection等，这些参数意义是相同的.
 * 读者可以认为Wrap和Flex（包括Row和Column）除了超出显示范围后Wrap会折行外，其它行为基本相同。
 * 下面我们看一下Wrap特有的几个属性：
 * spacing：主轴方向子widget的间距
 * runSpacing：纵轴方向的间距
 * runAlignment：纵轴方向的对齐方式
 *
 * */