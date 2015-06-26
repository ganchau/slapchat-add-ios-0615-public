//
//  FISMessageViewController.m
//  slapChat
//
//  Created by Gan Chau on 6/26/15.
//  Copyright (c) 2015 Joe Burgess. All rights reserved.
//

#import "FISMessageViewController.h"
#import "FISDataStore.h"
#import "Message.h"

@interface FISMessageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (strong, nonatomic) FISDataStore *store;

@end

@implementation FISMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.store = [FISDataStore sharedDataStore];
    
    self.saveButton.layer.cornerRadius = 10.0;
    [self.messageTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTapped:(id)sender
{
    /// do something here ///
    
    if (![[self.messageTextField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        Message *newMessage = [NSEntityDescription insertNewObjectForEntityForName:@"Message"
                                                            inManagedObjectContext:self.store.managedObjectContext];
        newMessage.content = self.messageTextField.text;
        newMessage.createdAt = [NSDate date];
        [self.store saveContext];
        
        [self.messageTextField resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to Save"
                                                    message:@"Message cannot be empty"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
        [alert show];
    }
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
