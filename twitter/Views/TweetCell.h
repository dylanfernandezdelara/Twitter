//
//  TweetCell.h
//  twitter
//
//  Created by dylanfdl on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pfPicture;
@property (weak, nonatomic) IBOutlet UILabel *realNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
- (IBAction)retweetButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *numRetweetsLabel;
- (IBAction)likeButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *numLikesLabel;

// not sure if this is NSDictionary or not
@property (nonatomic, strong) Tweet *tweet;

@end

NS_ASSUME_NONNULL_END
