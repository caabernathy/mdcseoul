/*
 * Copyright 2012 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ViewController.h"
#import "AppDelegate.h"
#import "MyShareViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;

@end

@implementation ViewController

#pragma mark - View lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark - Share methods
- (IBAction)shareUserOwnedBookAction:(id)sender {
    // Create an action
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    
    // Attach a book object to the action
    action[@"book"] = @{
                        @"type": @"books.book",
                        @"fbsdk:create_object": @YES,
                        @"title": @"The Tipping Point",
                        @"url": @"http://furious-mist-4378.herokuapp.com/books/the_tipping_point/",
                        @"image": @"http://www.renderready.com/wp-content/uploads/2011/02/the_tipping_point.jpg",
                        @"description": @"How Little Things Can Make a Big Difference",
                        @"data": @{@"isbn": @"0-316-31696-2"}
                        };
    
//    // Show pre-selection of a place and a friend
//    id<FBGraphPlace> place = (id<FBGraphPlace>)[FBGraphObject graphObject];
//    [place setId:@"191206170926721"]; // Facebook Menlo Park
//    [action setPlace:place]; // set place tag
//    [action setTags:@[@"100003086810435"]]; // set user tags
    
    // Show the share dialog to publish the book read action
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"books.reads"
                                 previewPropertyName:@"book"
                                             handler:
     ^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
             NSLog(@"Error: %@", error.description);
         } else {
             NSLog(@"Success!");
         }
     }];
}

- (IBAction)shareAppOwnedBookAction:(id)sender {
    // Create an action
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    
    // Attach a book object to the action
    action[@"book"] = @"442064879213253";
    
    // Show the share dialog to publish the book read action
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"books.reads"
                                 previewPropertyName:@"book"
                                             handler:
     ^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
             NSLog(@"Error: %@", error.description);
         } else {
             NSLog(@"Success!");
         }
     }];
}

- (IBAction)shareSelfHostedBookAction:(id)sender {
    // Create an action
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    
    // Attach a self-hosted (web url) book object to the action
    action[@"book"] = @"http://furious-mist-4378.herokuapp.com/books/bloodline.html";
    
    // Show the share dialog to publish the book read action
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"books.reads"
                                 previewPropertyName:@"book"
                                             handler:
     ^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
             NSLog(@"Error: %@", error.description);
         } else {
             NSLog(@"Success!");
         }
     }];
}

- (IBAction)shareCreateCollageAction:(id)sender {
    // Create an action
    id<FBOpenGraphAction> action = (id<FBOpenGraphAction>)[FBGraphObject graphObject];
    
    // Attach a book object to the action
    action[@"collage"] = @{
                        @"type": @"mobdevcon:collage",
                        @"fbsdk:create_object": @YES,
                        @"title": @"My Collage",
                        @"url": @"https://furious-mist-4378.herokuapp.com/collage/collage123/",
                        @"image": @"https://furious-mist-4378.herokuapp.com/collage/my_collage.jpg",
                        @"description": @"My first collage."
                        };
    
    // Show the share dialog to publish the book read action
    [FBDialogs presentShareDialogWithOpenGraphAction:action
                                          actionType:@"mobdevcon:create"
                                 previewPropertyName:@"collage"
                                             handler:
     ^(FBAppCall *call, NSDictionary *results, NSError *error) {
         if(error) {
             NSLog(@"Error: %@", error.description);
         } else {
             NSLog(@"Success!");
         }
     }];
}

- (IBAction)shareAPIBookAction:(id)sender {
    // First check that the user has an active session
    if (!FBSession.activeSession.isOpen) {
        [[[UIAlertView alloc]
          initWithTitle:@""
          message:@"Please log in with Facebook to share."
          delegate:nil
          cancelButtonTitle:@"OK"
          otherButtonTitles:nil, nil] show];
        return;
    }
    
    // Create the data input for the customized UI Share Dialog
    NSDictionary *bookInfo = @{@"image": [UIImage imageNamed:@"a_game_of_thrones.jpg"],
                               @"privacy": @YES,
                               @"object": @{
                                       @"type": @"books.book",
                                       @"fbsdk:create_object": @YES,
                                       @"title": @"A Game of Thrones",
                                       @"url": @"https://furious-mist-4378.herokuapp.com/books/a_game_of_thrones/",
                                       @"image": @"https://furious-mist-4378.herokuapp.com/books/a_game_of_thrones.png",
                                       @"description": @"In the frozen wastes to the north of Winterfell, sinister and supernatural forces are mustering.",
                                       @"data": @{@"isbn": @"0-553-57340-3"}
                                       }
                               };
    
    MyShareViewController *viewController =
    [[MyShareViewController alloc] initWithItem:bookInfo
                                     objectType:@"book"
                                     actionType:@"books.reads"];
    [self presentViewController:viewController
                       animated:YES
                     completion:nil];
}

#pragma mark - LoginView Delegate Methods
/*
 * Handle the logged in scenario
 */
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
}

/*
 * Handle the logged out scenario
 */
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
}

/*
 * When user info fetched personalize the experience
 */
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
}

@end