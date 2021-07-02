//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by dylanfdl on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "APIManager.h"

@interface TweetDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *FullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *atHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesNumLabel;

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *URLString = self.detailed_tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profilePic.image = [UIImage imageWithData:urlData];
    self.profilePic.layer.cornerRadius  = self.profilePic.frame.size.width/2;
    
    self.FullNameLabel.text = self.detailed_tweet.user.name;
    self.atHandleLabel.text = [@"@" stringByAppendingString:self.detailed_tweet.user.screenName];
    self.tweetContentLabel.text = self.detailed_tweet.text;
    self.dateTimeLabel.text = self.detailed_tweet.createdAtString;
    self.retweetNumLabel.text = [@(self.detailed_tweet.retweetCount).stringValue stringByAppendingString:@" RETWEETS"];
    self.likesNumLabel.text =[@(self.detailed_tweet.favoriteCount).stringValue stringByAppendingString:@" FAVORITES"];
    self.likeButton.selected = self.detailed_tweet.favorited;
    self.retweetButton.selected = self.detailed_tweet.retweeted;
}
- (IBAction)retweetNowButton:(UIButton *)sender {
    if (self.detailed_tweet.retweeted == YES){
        self.detailed_tweet.retweeted = NO;
        self.detailed_tweet.retweetCount -= 1;
        self.retweetNumLabel.text = [@(self.detailed_tweet.retweetCount).stringValue stringByAppendingString:@" RETWEETS"];
        self.retweetButton.selected = self.detailed_tweet.retweeted;
        [[APIManager shared] unretweet:self.detailed_tweet completion:^(Tweet *tweet, NSError *error){
            if (error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unretweeted the following Tweet: %@", self.detailed_tweet.text);
            }
        }];
    }
    else if (self.detailed_tweet.retweeted == NO){
        self.detailed_tweet.retweeted = YES;
        self.detailed_tweet.retweetCount += 1;
        self.retweetNumLabel.text =[@(self.detailed_tweet.retweetCount).stringValue stringByAppendingString:@" RETWEETS"];
        self.retweetButton.selected = self.detailed_tweet.retweeted;
        [[APIManager shared] retweet:self.detailed_tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", self.detailed_tweet.text);
             }
         }];
    }
}

- (IBAction)favoriteNowButton:(UIButton *)sender {
    if (self.detailed_tweet.favorited == YES){
        self.detailed_tweet.favorited = NO;
        self.detailed_tweet.favoriteCount -= 1;
        self.likesNumLabel.text = [@(self.detailed_tweet.favoriteCount).stringValue stringByAppendingString:@" FAVORITES"];
        self.likeButton.selected = self.detailed_tweet.favorited;
        [[APIManager shared] unfavorite:self.detailed_tweet completion:^(Tweet *tweet, NSError *error){
            if (error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else if (self.detailed_tweet.favorited == NO){
        self.detailed_tweet.favorited = YES;
        self.detailed_tweet.favoriteCount += 1;
        self.likesNumLabel.text = [@(self.detailed_tweet.favoriteCount).stringValue stringByAppendingString:@" FAVORITES"];
        self.likeButton.selected = self.detailed_tweet.favorited;
        [[APIManager shared] favorite:self.detailed_tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", self.detailed_tweet.text);
             }
         }];
    }
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
