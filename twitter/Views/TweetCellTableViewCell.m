//
//  TweetCellTableViewCell.m
//  twitter
//
//  Created by laurenjle on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "TweetCellTableViewCell.h"
#import "Tweet.h"

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
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    
    //update UIView after user taps like button
    self.faveCount.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    //[self refreshData];
    
    
}

//update all UIviews after user taps like button
/*- (void) refreshData{
    NSString *faveCountString = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
   
}*/

@end
