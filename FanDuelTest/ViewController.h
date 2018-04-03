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
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer1_img;
@property (strong, nonatomic) IBOutlet UIButton *btnPlayer2_img;
@property (strong, nonatomic) IBOutlet UILabel *gameInstruction;
@property (strong, nonatomic) IBOutlet UILabel *gameScore;
@property (strong, nonatomic) IBOutlet UILabel *player1_fppg;
@property (strong, nonatomic) IBOutlet UILabel *player2_fppg;
@property (strong, nonatomic) IBOutlet UILabel *choiceResult;
@property (strong, nonatomic) IBOutlet UIButton *btnNewSelection;

- (IBAction)choosePlayer1;
- (IBAction)choosePlayer2;

- (BOOL)load_playerJSON;
- (void)selectRandomPlayers_withNoDraw;


@end

