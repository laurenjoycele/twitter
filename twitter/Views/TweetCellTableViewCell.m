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
    if (self.tweet.favorited){
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
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

//update all UIviews after user taps like button
/*- (void) refreshData{
    NSString *faveCountString = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
   
}*/

@end
