//
//  ViewController.h
//  FanDuelTest
//
//  Created by mark.bonsor on 03/04/2018.
//  Copyright © 2018 MiB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *btnPlayer1;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer2;
@property (strong, nonatomic) IBOutlet UIImageView *imgPlayer1;
@property (strong, nonatomic) IBOutlet UIImageView *imgPlayer2;

- (IBAction)choosePlayer1;
- (IBAction)choosePlayer2;

- (BOOL)load_playerJSON;
- (void)selectRandomPlayers;


@end

