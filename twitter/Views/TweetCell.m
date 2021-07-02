//
//  TweetCell.m
//  twitter
//
//  Created by dylanfdl on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "ProfileViewController.h"

@implementation TweetCell
- (IBAction)tapMovetoProfile:(UIButton *)sender {
    // segue is handled in timelineViewController
}

- (IBAction)didTapFavorite:(UIButton *)sender {
    if (self.tweet.favorited == YES){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        self.numLikesLabel.text = @(self.tweet.favoriteCount).stringValue;
        self.likeButton.selected = self.tweet.favorited;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error){
            if (error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
    else if (self.tweet.favorited == NO){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        self.numLikesLabel.text =@(self.tweet.favoriteCount).stringValue;
        self.likeButton.selected = self.tweet.favorited;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.pfPicture.layer.cornerRadius  = self.pfPicture.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapRetweet:(UIButton *)sender {
    if (self.tweet.retweeted == YES){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        self.numRetweetsLabel.text = @(self.tweet.retweetCount).stringValue;
        self.retweetButton.selected = self.tweet.retweeted;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error){
            if (error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else {
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    else if (self.tweet.retweeted == NO){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        self.numRetweetsLabel.text =@(self.tweet.retweetCount).stringValue;
        self.retweetButton.selected = self.tweet.retweeted;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
}

@end
