//
//  ViewController.h
//  InstaDemo
//
//  Created by Hardik Trivedi on 05/09/2015.
//  Copyright (c) 2015 iHartDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
{
    AppDelegate *objAppDelegate;
}

@property (strong, nonatomic) IBOutlet UILabel *lblUsername;
@property (strong, nonatomic) IBOutlet UILabel *lblFullname;
@property (strong, nonatomic) IBOutlet UILabel *lblWebsite;
@property (strong, nonatomic) IBOutlet UIImageView *ivUserPhoto;

@end

