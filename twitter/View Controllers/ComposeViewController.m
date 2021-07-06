//
//  ComposeViewController.m
//  twitter
//
//  Created by dylanfdl on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import <QuartzCore/QuartzCore.h> 

@interface ComposeViewController ()
- (IBAction)closeButton:(UIBarButtonItem *)sender;
- (IBAction)tweetButton:(UIBarButtonItem *)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self.textViewArea layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.textViewArea layer] setBorderWidth:1];
    [[self.textViewArea layer] setCornerRadius:15];
}

- (IBAction)tweetButton:(UIBarButtonItem *)sender {
    [[APIManager shared] postStatusWithText:self.textViewArea.text completion:^(Tweet *tweets, NSError *error) {
        if (tweets){
            [self.delegate didTweet:tweets];
            NSLog(@"Successfully composed tweet");
        }
        else {
            NSLog(@"Error composing tweet: %@", error.localizedDescription);
        }
        [self dismissViewControllerAnimated:true completion:nil];
    }];
}

- (IBAction)closeButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
