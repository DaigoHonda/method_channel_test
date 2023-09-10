#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
  // FlutterViewControllerを取得
  FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

  // Method Channelを作成
  FlutterMethodChannel* nativeViewChannel = [FlutterMethodChannel
                                      methodChannelWithName:@"com.example.flutter_method_channel/method"
                                      binaryMessenger:controller.binaryMessenger];

  // Method ChannelでFlutterからのメッセージをリッスン
  [nativeViewChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    // 'showNativeView'メソッドを呼び出すことを期待
    if ([@"test" isEqualToString:call.method]) {
      [self showNativeView];
      result(@"Native view is shown");
    } else {
      result(FlutterMethodNotImplemented);
    }
  }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)showNativeView {
  // UIViewControllerを作成
  UIViewController *nativeViewController = [[UIViewController alloc] init];
  
  // 背景色を設定
  nativeViewController.view.backgroundColor = [UIColor whiteColor];
  
  // UIButtonを作成
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  [button setFrame:CGRectMake(0, 0, 200, 50)];
  [button setCenter:nativeViewController.view.center];
  [button setTitle:@"Back to Flutter" forState:UIControlStateNormal];
  
  // イベントハンドラを追加
  [button addTarget:self action:@selector(closeNativeView:) forControlEvents:UIControlEventTouchUpInside];
  
  // UIButtonをUIViewControllerに追加
  [nativeViewController.view addSubview:button];

  // UIWindowを取得
  UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
  
  // アニメーション前に透明に設定
  nativeViewController.view.alpha = 0;
  nativeViewController.view.tag = 1111; // タグを設定
  
  // UIWindowにUIViewControllerのviewを追加
  [keyWindow addSubview:nativeViewController.view];

  // フェードインアニメーション
  [UIView animateWithDuration:0.5 animations:^{
    nativeViewController.view.alpha = 1;
  }];
}


- (void)closeNativeView:(UIButton *)button {
  UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
  UIView *nativeView = [keyWindow viewWithTag:1111];  // タグを使ってUIViewを見つける
  [nativeView removeFromSuperview];  // UIViewを削除
}

@end
