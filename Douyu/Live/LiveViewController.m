//
//  LiveViewController.m
//  Douyu
//
//  Created by Shui on 2017/9/10.
//  Copyright © 2017年 Shui. All rights reserved.
//

#import "LiveViewController.h"
#import <Photos/Photos.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface LiveViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
//    self.navigationItem.rightBarButtonItem = UI
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)loadMedia:(id)sender {
//    [self startMediaBrowserFromViewController:self usingDelegate:self];
    
//    [self playWithPlayerViewController];
    
    [self playWithPlayerController];
//    [self avPlayerVC];
}

- (void) avPlayerVC
{
    NSURL * url                         = [[NSBundle mainBundle] URLForResource:@"YYS(WL)-color.mp4" withExtension:nil];
    //创建控制器
    AVPlayerViewController *_pvc        = [[AVPlayerViewController alloc] init];
    _pvc.player                         = [AVPlayer playerWithURL:url];
    
    _pvc.view.frame                     = CGRectMake(20, 20, 300, 150);
    //    创建View的大小
    [self.view addSubview:_pvc.view];
//        [self presentViewController:_pvc animated:YES completion:nil];
    
    //播放视频
    [_pvc.player play];
}

- (void) playWithPlayerController
{
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"YYS(WL)-color.mp4" withExtension:nil];
    //NSURL *url2 = [NSURL fileURLWithPath:[url absoluteString]];
    MPMoviePlayerController *_mpc = [[MPMoviePlayerController alloc] initWithContentURL:url];  //_mpc是一个MPMoviePlayerController类型的成员变量
    [self addNotification:_mpc];
    
    
    _mpc.view.frame = self.view.bounds;//CGRectMake(40, 40, 300, 400);
//    _mpc.scalingMode = MPMovieScalingModeAspectFit;
    _mpc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _mpc.movieSourceType = MPMovieSourceTypeStreaming;// 播放本地视频时需要这句
    _mpc.controlStyle = MPMovieControlStyleFullscreen;
    _mpc.shouldAutoplay = YES;// 是否自动播放（默认为YES）
//    [_mpc.player prepareToPlay];//开始缓存
    
    [self.view addSubview:_mpc.view];

   

//    [self presentViewController:_mpc animated:YES completion:nil];   //这里是不能直接这样modal出该控制器的,如果这样写的话,程序会崩溃.
    [_mpc play];
}

-(void)addNotification:(MPMoviePlayerController *) moviePlayer {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
}

- (void) mediaPlayerPlaybackStateChange:(NSNotification *)sender
{
    MPMoviePlayerController *moviePlayer = sender.object;
    NSLog(@"sender=%f", moviePlayer.currentPlaybackTime);
    NSLog(@"sender=%f", moviePlayer.currentPlaybackRate);
    
    switch (moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",moviePlayer.playbackState);
            break;
    }
}

- (void) mediaPlayerPlaybackFinished:(NSNotification *)sender
{
//    MPMoviePlayerController *ctrol = sender.object;
    NSLog(@"--wcompleted!!!!!!");
}

- (void) playWithPlayerViewController
{
    //这里加载了一个Bundle路径下的mp4文件
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"YYS(WL)-color.mp4" withExtension:nil];
    //_mpc是一个MPMoviePlayerViewController类型的成员变量.
    MPMoviePlayerViewController *mpc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:mpc animated:YES completion:nil];  //这里我们可以直接present出该控制器.
}

- (void) chooseVideoForPlay:(id)sender
{
    //
}

#pragma mark UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    NSURL *movieUrl;
    
    // Handle a movied picked from a photo album
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSString *moviePath = [[info objectForKey:UIImagePickerControllerMediaURL] path];
        movieUrl = [NSURL URLWithString:moviePath];
    }

    //
    
    //__weak id weakself = self;
    [self dismissViewControllerAnimated:NO completion:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
            MPMoviePlayerViewController *movieVC = [[MPMoviePlayerViewController alloc]initWithContentURL:movieUrl];
        NSLog(@"movieUrl=%@", movieUrl);
            [movieVC.moviePlayer prepareToPlay];
            movieVC.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
            movieVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        
            [movieVC.view setBackgroundColor:[UIColor clearColor]];
            [movieVC.view setFrame:self.view.bounds];
        
//            [[NSNotificationCenter defaultCenter] addObserver:weakself selector:@selector(movieFinishedCallback:)
//                                                         name:MPMoviePlayerPlaybackDidFinishNotification
//                                                       object:movieVC.moviePlayer];
        
//            [weakself presentMoviePlayerViewControllerAnimated:movieVC];
        [self presentViewController:movieVC animated:YES completion:nil];
//        });
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark finish movie callback

- (void) movieFinishedCallback:(NSNotification*)notify
{
    // 视频播放完或者在presentMoviePlayerViewControllerAnimated下的Done按钮被点击响应的通知。
    MPMoviePlayerController* theMovie = [notify object];

    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                  name:MPMoviePlayerPlaybackDidFinishNotification
                                                object:theMovie];
    [self dismissMoviePlayerViewControllerAnimated];
}

#pragma mark misc

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;

    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:YES completion:nil];
    return YES;
}

@end
