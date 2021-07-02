//
//  ProfileViewController.h
//  twitter
//
//  Created by dylanfdl on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"



NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : UIViewController

@property (nonatomic, strong) Tweet *detailed_tweet;

@end

NS_ASSUME_NONNULL_END
