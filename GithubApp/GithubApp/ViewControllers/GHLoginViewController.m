//
//  GHLoginViewController.m
//  GithubApp
//
//  Created by Joe Goullaud on 7/16/13.
//  Copyright (c) 2013 Raizlabs. All rights reserved.
//

#import "GHLoginViewController.h"
#import "GHWebServiceManager.h"

@interface GHLoginViewController ()

@end

@implementation GHLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
    GHWebServiceManager *webManager = [GHWebServiceManager defaultManager];
    
    webManager.username = self.usernameTextField.text;
    webManager.password = self.passwordTextField.text;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    
    return NO;
}

@end
