//
//  LicenseViewController.m
//  diapersens
//
//  Created by Yi Zhu on 6/26/18.
//  Copyright © 2018 Nordic Semiconductor. All rights reserved.
//

#import "LicenseViewController.h"

@interface LicenseViewController ()
@property (weak, nonatomic) IBOutlet UITextView *licenseTextView;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;
@end

@implementation LicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"terms_cn" ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.licenseTextView.text = content;
    self.licenseTextView.editable = NO;
    self.navigationItem.title = @"Terms and Conditions";
    //self.navigationItem.title = @"免责声明";

    BOOL licenseAccepted = NO;
    NSString *ppath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"diapersens-1.0.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:ppath isDirectory:nil]) {
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:ppath];
        NSDictionary *configDict = dict[@"Config"];
        licenseAccepted = [configDict[@"LicenseAccepted"] boolValue];
    }
    if (licenseAccepted) {
        self.acceptButton.hidden = YES;
    }
}
- (IBAction)acceptPushed:(id)sender {
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"diapersens-1.0.plist"];
    NSDictionary *configDict = @{ @"LicenseAccepted" : @"1"};
    NSDictionary *dict = @{ @"Config": configDict };
    if (![dict writeToFile:path atomically:YES]) {
        NSLog(@"write failed: %@", path);
    }
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
