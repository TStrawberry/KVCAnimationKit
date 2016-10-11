# KVCAnimationKit

	这是一个小框架, 提供了一种渐进方式来设置基本数据类型的值, 接口采用的是与KVC类似的通用接口(用id类型传值),并且支持常用结构体成员变量的修改,用法简单:
    
    [[[[self.orangeView setValue:[NSValue valueWithCGSize:CGSizeMake(300, 200)] forKeyPath:@"bounds.size" duraion:2.0] withProgress:^(double progress, id currenValue) {

        NSLog(@"%@", currenValue);
    }] withCompletion:^{
        NSLog(@"withCompletion");
    }] commit];
    
    [[self.orangeView setValue:[NSValue valueWithCGSize:CGSizeMake(300, 200)] forKeyPath:@"bounds.size" duraion:2.0] commit];
    [[self setValue:@400 forKeyPath:@"orangeView.center.y" duraion:1.5] commit];
    [[self setValue:@0.2 forKeyPath:@"blueView.alpha" duraion:2.0] commit];
    [[self setValue:[NSValue valueWithCGPoint:CGPointMake(120, 70)] forKeyPath:@"redView.frame.origin" duraion:3.0] commit];
    [[[self setValue:@130 forKeyPath:@"blackView.frame.origin.x" duraion:1.5] withCompletion:^{
        NSLog(@"*********");
    }] commit];
