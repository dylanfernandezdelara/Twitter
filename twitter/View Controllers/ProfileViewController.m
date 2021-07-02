//
//  ProfileViewController.m
//  twitter
//
//  Created by dylanfdl on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *URLString = self.detailed_tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePic.image = [UIImage imageWithData:urlData];
    self.profilePic.layer.cornerRadius  = self.profilePic.frame.size.width/2;
    
    self.fullNameLabel.text = self.detailed_tweet.user.name;
    self.atHandleLabel.text = [@"@" stringByAppendingString: self.detailed_tweet.user.screenName];
    self.followersLabel.text = [self.detailed_tweet.user.followersCount.stringValue stringByAppendingString:@" FOLLOWERS"];
    self.followingLabel.text = [self.detailed_tweet.user.followingCount.stringValue stringByAppendingString:@" FOLLOWING"];
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
