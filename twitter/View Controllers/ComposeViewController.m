//
//  ComposeViewController.m
//  twitter
//
//  Created by laurenjle on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tweetTextBox;

@end

@implementation ComposeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)tweetSomething:(id)sender {
    [[APIManager shared] postStatusWithText:_tweetTextBox.text completion:^(Tweet * myTweet, NSError* error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:myTweet];
            NSLog(@"Compose Tweet Success!");
            [self cancelTweet:self];
        }
    }];
    
}


- (IBAction)cancelTweet:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
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
