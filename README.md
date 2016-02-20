# FTYGroupTableView
这是有三个按钮分表对应一个tableView，其中第一个是有两个tableView合成的，主要的功能是通过三张tableView的复选框，选中某一个或者多个，再由一个确定按钮来把三张表选中的选项拿出来，可能存在bug，还有功能不是很完善，也不是一个框架，只是供大家学习一下。但是接下来会继续修改。如果什么不好的地方，希望各位大神指点一下。谢谢大家的支持


使用方法：
  在控制器中初始化视图
  
  FTYMainView *mainView = [[FTYMainView alloc] init];
  
  // 文件名可以写areaNo.plist
  
    mainView.areaNoPlistName = @"areaNo";
    
    mainView.typeNoPlistName = @"typeNo";
    
    mainView.stageNoPlistName = @"stageNo";
    
    mainView.frame = self.view.bounds;
    
    [self.view addSubview:mainView];
