//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TimelineViewController ()<ComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>
- (IBAction)logOutButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arrayOfTweets;

// UIRefreshControl is an object that handles refreshing
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self getTimeline];
    
    // allocated refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getTimeline) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    
    
}

- (void)getTimeline {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            // added a typecast here to be mutable array but not 100% sure if this is correct
            self.arrayOfTweets = tweets;
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *temp in tweets) {
                // this used to be array
                NSString *text = temp.text;
                NSLog(@"%@", text);
            }
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutButton:(UIButton *)sender {
    // TimelineViewController.m
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    // sets root view to login view controller page
    // CHANGES VIEW CONTROLLER WITH BUTTON CLICK
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    Tweet *tweet_curr = self.arrayOfTweets[indexPath.row];
    // NSLog(@"STRING: %@", tweet_curr.idStr);
    
    // set all properties of cell
    cell.realNameLabel.text = tweet_curr.user.name;
    cell.userNameLabel.text = [@"@" stringByAppendingString:tweet_curr.user.screenName];
    cell.tweetDateLabel.text = tweet_curr.createdAtString;
    cell.tweetContentLabel.text = tweet_curr.text;
    cell.numRetweetsLabel.text = @(tweet_curr.retweetCount).stringValue;
    cell.numLikesLabel.text = @(tweet_curr.favoriteCount).stringValue;
    
    // NSString *URLString = [tweet_curr.user.profilePicture stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSString *URLString = tweet_curr.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.pfPicture.image = [UIImage imageWithData:urlData];
    cell.pfPicture.layer.cornerRadius = 15;
    cell.tweet = tweet_curr;
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"COUNT: %lu", self.arrayOfTweets.count);
    return self.arrayOfTweets.count;
}


- (void)didTweet:(nonnull Tweet *)tweet {
    // new tweets to the tweet array
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    // reload timeline
    [self.tableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

@end
