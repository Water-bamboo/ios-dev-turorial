//
//  ThirdTableViewController.m
//  iOSTutorial
//
//  Created by Shui on 2017/9/16.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "ThirdTableViewController.h"
#import "DemoPopViewController.h"
#import "CADemoRootTableViewController.h"

static NSString *REUSABLE_CELL_ID = @"REUSABLE_CELL_ID";

@interface ThirdTableViewController ()

@property (nonatomic, strong) NSDictionary *allSectionDict;

@end

@implementation ThirdTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"所有的例子";

    NSDictionary *sectionList = @{@"Animation":@[[CADemoRootTableViewController class]],
                                  @"Media":[NSNull class],
                                  @"OpenGL":[NSNull class],
                                  @"Player":[NSNull class],
                                  @"UI":@[[DemoPopViewController class]],
                                  @"UI-Transition":@[@"CustomTransition"]};

    _allSectionDict = [[NSDictionary alloc] initWithDictionary:sectionList copyItems:YES];
    
    //init tableview
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:REUSABLE_CELL_ID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _allSectionDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id key = [_allSectionDict allKeys][section];
    id value = [_allSectionDict valueForKey:key];
    if ([value isKindOfClass:[NSArray class]]) {
        return ((NSArray *)value).count;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString * key = [_allSectionDict allKeys][section];
    return key;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSABLE_CELL_ID forIndexPath:indexPath];
    
    id key = [_allSectionDict allKeys][indexPath.section];
    NSArray * valueArray = [_allSectionDict valueForKey:key];
    
    NSAssert([valueArray isKindOfClass:[NSArray class]], @"value list must in a NSArray.");
    
    id value = valueArray[indexPath.row];
    NSLog(@"valueArray[%ld] = %@", indexPath.row, value);
    
    if ([value isKindOfClass:[NSString class]]) {
        [cell.textLabel setText: value];
    }
    else {
        [cell.textLabel setText: NSStringFromClass(value)];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id key = [_allSectionDict allKeys][indexPath.section];
    NSArray * valueArray = [_allSectionDict valueForKey:key];
    
    NSAssert([valueArray isKindOfClass:[NSArray class]], @"value list must in a NSArray.");

    id value = valueArray[indexPath.row];
    NSLog(@"didSelect: valueArray[%ld] = %@", indexPath.row, value);

    if (valueArray.count == 1) {
        if ([value isKindOfClass:[NSString class]]) {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:value bundle:nil];
            UIViewController *vc = [storyBoard instantiateInitialViewController];
            [self presentViewController:vc animated:YES completion:nil];
        }
        else {
            [self.navigationController pushViewController:[value new] animated:YES];
        }
    }
    else {
        
    }
    //
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
