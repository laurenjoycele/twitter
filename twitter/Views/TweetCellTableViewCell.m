//
//  TweetCellTableViewCell.m
//  twitter
//
//  Created by laurenjle on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCellTableViewCell
@synthesize favoritedButton;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLike:(id)sender {
    if (self.tweet.favorited == YES){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        //set heart to gray
        UIImage *unlikeButtonImage = [UIImage imageNamed:@"favor-icon"];
        [self.favoritedButton setImage:unlikeButtonImage forState:UIControlStateNormal];
        self.faveCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    else{
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        //update UIView after user taps like button
        self.faveCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
        //set heart to red
        UIImage *favButtonImage = [UIImage imageNamed:@"favor-icon-red"];
        [self.favoritedButton setImage:favButtonImage forState:UIControlStateNormal];
        
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

- (IBAction)didTapRetweet:(id)sender {
    //undo retweet
    if (self.tweet.retweeted == YES){
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        //set retweet image back to gray
        UIImage *unretweetButtonImage = [UIImage imageNamed:@"retweet-icon"];
        [self.retweetButton setImage:unretweetButtonImage forState:UIControlStateNormal];
        self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
        //check if successful unretweet
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
    //retweet
    else{
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        //set retweet image to green
        UIImage *retweetButtonImage = [UIImage imageNamed:@"retweet-icon-green"];
        [self.retweetButton setImage:retweetButtonImage forState:UIControlStateNormal];
        //cehck if successful retweet
        self.retweetCount.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }
    
    
}


//update all UIviews after user taps like button
/*- (void) refreshData{
    NSString *faveCountString = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
   
}*/

@end
