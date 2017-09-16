//
//  LeavesViewController.m
//  CoreAnimation
//
//  Created by Shui on 2017/9/9.
//
//

#import "LeavesViewController.h"

@interface LeavesViewController ()

@property (nonatomic, strong) UILabel * label1;
@property (nonatomic, strong) UILabel * label2;

@end

@implementation LeavesViewController

+ (NSString *)displayName {
    return @"Leaves flipper";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    _label1.text = @"Shuizhu";
    [self.view addSubview:self.label1];

    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
    _label2.text = @"Mardegebi";
    [self.view addSubview:self.label2];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    _label1.transform = CGAffineTransformMakeScale(1, 0);
    _label1.alpha = 0;
    _label2.alpha = 1;
    [UIView animateWithDuration: 2. animations: ^ {
        _label1.transform = CGAffineTransformMakeScale(1, 1);
        _label2.transform = CGAffineTransformMakeScale(1, 0.1);
        _label1.alpha = 1;
        _label2.alpha = 0;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
