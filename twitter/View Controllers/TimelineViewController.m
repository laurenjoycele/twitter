//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCellTableViewCell.h"
#import "Tweet.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"


@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate, ComposeViewControllerDelegate>

@property(nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView; //View controller has tableView as a subview
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TimelineViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //view controlled becomes its dataSource and delegate
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    //make API request
    // Get timeline. Comes back and executes this code until new data is ready
    //API manager calls completion handler passing back data
  
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets; //view controller stores data passed into completion handler
            [self.tableView reloadData]; //gets new info
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    //initialize refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    //bind action to refresh control
    [self.refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    //insert refresh control in table view
    
    
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count; //number of items returned from API
}



//returns an instance of the custom cell w/ reuse identifier w/ it's elements populated w/data at index asked for
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //reuse cells
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCellTableViewCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.tweet = tweet;
    
    //outlets & data
    cell.authorLabel.text = tweet.user.name;
    cell.screenName.text = tweet.user.screenName;
    cell.dateLabel.text = tweet.createdAtString;
    //text
    cell.textBox.text = tweet.text;
    cell.retweetCount.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    cell.faveCount.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    
    
    //dynamic row height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    //use for profile pic
    NSString *ProfileURLString = tweet.user.profilePicture;
    NSURL *posterURL = [NSURL  URLWithString:ProfileURLString];
    [cell.profPic setImageWithURL:posterURL];
    
    return cell;
}

- (void)updateTweet: (TweetCellTableViewCell *)cell{
    
}

//composing a tweet
- (void)didTweet:(Tweet *)tweet{
    [self.tableView reloadData];
}


//**************** methods for refresh ********************
//implements action to update table view
- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.tweets = tweets;
            [self.tableView reloadData];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            for (Tweet *tweet in tweets) {
                NSString *text = tweet.text;
                NSLog(@"%@", text);
            }
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}


//need help understanding this 
- (IBAction)loggingOut:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    [[APIManager shared] logout];
}
    


@end
