//
//  GZSAuthController.m
//  SlackClient
//
//  Created by George Zinyakov on 11/5/16.
//  Copyright © 2016 George Zinyakov. All rights reserved.
//

#import "GZSAuthController.h"

@interface GZSAuthController ()
@property (weak, nonatomic) IBOutlet UIWebView *authorizationWebView;

@property (readwrite, nonatomic, strong) GZSAccountService *accountService;
@end

@implementation GZSAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.accountService = [GZSAccountService new];
    [self loadAuthRequestInWebView:self.authorizationWebView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if ([request.URL.scheme isEqual: @"slackclientscheme"]) {
        NSString *code = [self getCodeForRequest:request];
        [[self.accountService logInWithCode:code]
         subscribeNext:^(id  _Nullable x) {
             [self performSegueWithIdentifier:kSegueFromAuthToContent sender:nil];
         } error:^(NSError * _Nullable error) {
             [self presentAlertWithTitle:@"Error" message:error.localizedDescription completionBlock:^{
                 [self loadAuthRequestInWebView:self.authorizationWebView];
             }];
         }];
    }
    return YES;
}

- (void)loadAuthRequestInWebView:(UIWebView * _Nonnull)webView {
    NSURLRequest *request = [self.accountService authorizationRequest];
    [webView loadRequest:request];
}

- (void)presentAlertWithTitle:(NSString * _Nonnull)title
                      message:(NSString * _Nonnull)message
              completionBlock:(void (^_Nonnull)(void))completionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self.navigationController presentViewController:alertController animated:YES completion:completionBlock];
}

- (NSString *)getCodeForRequest:(NSURLRequest * _Nonnull)request {
    NSArray *queryParams = [request.URL.query componentsSeparatedByString:@"&"];
    NSArray *codeParam = [queryParams filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF BEGINSWITH %@", @"code="]];
    NSString *codeQuery = [codeParam objectAtIndex:0];
    NSString *code = [codeQuery stringByReplacingOccurrencesOfString:@"code=" withString:@""];
    return code;
}

@end
