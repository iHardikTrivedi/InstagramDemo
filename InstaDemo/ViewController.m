//
//  ViewController.m
//  InstaDemo
//
//  Created by Hardik Trivedi on 05/09/2015.
//  Copyright (c) 2015 iHartDevelopers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <IGSessionDelegate, IGRequestDelegate>

@end

@implementation ViewController

#pragma mark - ViewLifeCycle Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    objAppDelegate = [[UIApplication sharedApplication] delegate];
}

#pragma mark - IGSessionDelegate Methods

- (void)igDidLogin
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram Login" message:@"Instagram account successfully login." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    
    NSMutableDictionary *mdicUserInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"users/self", @"method", nil];
    [objAppDelegate.instagram requestWithParams:mdicUserInfo delegate:self];
}

- (void)igDidNotLogin:(BOOL)cancelled
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram Login Error" message:@"Error occured, Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)igDidLogout
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram Logout" message:@"Instagram account successfully logout." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)igSessionInvalidated
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram Session Error" message:@"Please Login in Instagram. Instagram Session was expired." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - IGRequestDelegate Methods

- (void)request:(IGRequest *)request didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Instagram Fail" message:[NSString stringWithFormat:@"Error : %@", [error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)request:(IGRequest *)request didLoad:(id)result
{
    NSLog(@"Instagram Feed : %@", result);
    
    [self.ivUserPhoto setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[result objectForKey:@"data"] valueForKey:@"profile_picture"]]]]];
    [self.lblUsername setText:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"] valueForKey:@"username"]]];
    [self.lblFullname setText:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"] valueForKey:@"full_name"]]];
    [self.lblWebsite setText:[NSString stringWithFormat:@"%@", [[result objectForKey:@"data"] valueForKey:@"website"]]];
}

#pragma mark - IBAction Methods

- (IBAction)btnInstagramLoginTapped:(id)sender
{
    [self initInstagramView];
}

#pragma mark - Other Methods

- (void)initInstagramView
{
    [objAppDelegate.instagram setSessionDelegate:self];
    [objAppDelegate.instagram authorize:[NSArray arrayWithObjects:@"comments", @"likes", nil]];
}

@end
