//
//  ComposeViewController.h
//  twitter
//
//  Created by laurenjle on 7/3/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN
//creates a contract betwen the ComposeViewController and whichever view controller presented it

@protocol ComposeViewControllerDelegate
- (void)didTweet:(Tweet *)tweet;
@end

@interface ComposeViewController : UIViewController
@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate; //use weak to avoid memory leaks

@end

NS_ASSUME_NONNULL_END
