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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *tweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) UIRefreshControl *refreshControl;
//@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TimelineViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // Get timeline
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
    }];
    
    //refresh
    //UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.tweets.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //reuse cells
    TweetCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCellTableViewCell"];
    Tweet *tweet = self.tweets[indexPath.row];
    
    //outlets & data
    cell.authorLabel.text = tweet.user.name;
    cell.screenName.text = tweet.user.screenName;
    cell.dateLabel.text = tweet.createdAtString;
    //text
    cell.textBox.text = tweet.text;
    cell.retweetCount.text = [NSString stringWithFormat:@"%d",tweet.retweetCount];
    cell.faveCount.text = [NSString stringWithFormat:@"%d",tweet.favoriteCount];
    //cell.retweetedButton
    UIImage *retweetImage = [UIImage imageNamed:@"retweet-icon.png"];
    [cell.retweetedButton setImage:retweetImage forState:UIControlStateNormal];
    //cell.favoritedButton
    UIImage *favoritedImage = [UIImage imageNamed:@"favor-icon.png"];
    [cell.favoritedButton setImage:favoritedImage forState:UIControlStateNormal];
    
    //dynamic row height
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //use for profile pic
    /*
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = //[baseURLString stringByAppendingString:posterURLString];
    NSLog(@"%@", fullPosterURLString);
    NSURL *posterURL = [NSURL  URLWithString:fullPosterURLString];*/
    //cell..image = tweet[@"profile_image_url_https"];
    //[cell.posterView setImageWithURL:posterURL];
    return cell;
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
}



@end
