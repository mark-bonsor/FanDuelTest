//
//  ViewController.m
//  FanDuelTest
//
//  Created by mark.bonsor on 03/04/2018.
//  Copyright © 2018 MiB. All rights reserved.
//

#import "ViewController.h"
#import "PlayerObject.h"



#define JSON_URL @"https://gist.githubusercontent.com/liamjdouglas/bb40ee8721f1a9313c22c6ea0851a105/raw/6b6fc89d55ebe4d9b05c1469349af33651d7e7f1/Player.json"



@interface ViewController ()

@property (nonatomic,strong) NSMutableArray *playerObjectHolderArray;

@property (nonatomic) int currentGameScore;
@property (nonatomic) int maxGameScore;
@property (nonatomic) BOOL awaitingChoice;
@property (nonatomic) BOOL gameInProgress;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _maxGameScore = 10; // The number of correct guesses required for the game to end
    
    [self load_playerJSON];
    
    [self startNewGame];
    
}


#pragma mark - JSON Methods

-(NSMutableArray *)playerObjectHolderArray{
    if(!_playerObjectHolderArray) _playerObjectHolderArray = [[NSMutableArray alloc]init];
    return _playerObjectHolderArray;
}


-(BOOL)load_playerJSON {
    
    BOOL playersLoaded;
    
    NSURL *dataURL = [NSURL URLWithString:JSON_URL];
    NSData *jsonData = [NSData dataWithContentsOfURL:dataURL];
    NSError *error = nil;
    
    if (jsonData != nil) {
        
        NSDictionary *dataDictionary = [NSJSONSerialization
                                        JSONObjectWithData:jsonData options:0 error:&error];
        
        
        if ([dataDictionary objectForKey:@"players"]!=[NSNull null]) {
            
            playersLoaded = TRUE;
            
            NSDictionary *playersArray = [dataDictionary objectForKey:@"players"];
            
            for (NSDictionary *aDictionary in playersArray) {
                
                NSDictionary *imageDict = [aDictionary objectForKey:@"images"];
                NSDictionary *defaultImageDict = [imageDict objectForKey:@"default"];
                
                if ([aDictionary objectForKey:@"fppg"]!=[NSNull null]) { // discard players with null fppg...
                    
                    PlayerObject *currenPlayer = [[PlayerObject alloc]initWithId:[[aDictionary objectForKey:@"id"]intValue]
                                                                      First_Name:[aDictionary objectForKey:@"first_name"]
                                                                       Last_Name:[aDictionary objectForKey:@"last_name"]
                                                                            FPPG:[[aDictionary objectForKey:@"fppg"] floatValue]
                                                                       ImageDict:defaultImageDict];
                    [self.playerObjectHolderArray addObject:currenPlayer];
                }
            }
            
        } else {
            
            playersLoaded = FALSE;
        }
        
    } else {
        
        playersLoaded = FALSE;
        
    }

    
    return playersLoaded;
}


#pragma mark - Player Selection Methods

-(void)selectRandomPlayers_withNoDraw{
    
    [self selectRandomPlayers];
    
    // Ensure that the selected players have different fppg values...
    
    while (_randomPlayer1.fppg == _randomPlayer2.fppg) {
        [self selectRandomPlayers];
    }
    
}

-(void)selectRandomPlayers {
    
    [self prepareForNewPlayers];
    
    int n = (int)self.playerObjectHolderArray.count;
    
    int r1 = arc4random_uniform(n);
    int r2 = (r1 + arc4random_uniform(n-1)) % n;
    
    _randomPlayer1 = self.playerObjectHolderArray[r1];
    _randomPlayer2 = self.playerObjectHolderArray[r2];
    
    NSString *player1_name = [NSString stringWithFormat:@"%@ %@", _randomPlayer1.first_name, _randomPlayer1.last_name];
    NSString *player2_name = [NSString stringWithFormat:@"%@ %@", _randomPlayer2.first_name, _randomPlayer2.last_name];
    
    _btnPlayer1.titleLabel.minimumScaleFactor = 0.5f;
    _btnPlayer1.titleLabel.adjustsFontSizeToFitWidth = YES;
    _btnPlayer2.titleLabel.minimumScaleFactor = 0.5f;
    _btnPlayer2.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [_btnPlayer1 setTitle:player1_name forState:UIControlStateNormal];
    [_btnPlayer2 setTitle:player2_name forState:UIControlStateNormal];
    
    NSString *player1_imgURL = _randomPlayer1.defaultImageURL;
    NSString *player2_imgURL = _randomPlayer2.defaultImageURL;
    
    UIImage *player1_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:player1_imgURL]]];
    UIImage *player2_image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:player2_imgURL]]];
    
    [_btnPlayer1_img setImage:player1_image forState:UIControlStateNormal];
    [_btnPlayer2_img setImage:player2_image forState:UIControlStateNormal];
    
    _awaitingChoice = TRUE;
    
}



#pragma mark - Game Play Methods

-(void)startNewGame {
    
    [self prepareForNewGame];
    [self selectRandomPlayers_withNoDraw];
    
}

- (void)showResults:(BOOL)correctGuess {
    
    if (correctGuess){
        _currentGameScore = _currentGameScore + 1;
        _choiceResult.text = @"CORRECT!";
        [self showGameScore];
    } else {
        _choiceResult.text = @"WRONG!";
    }
    
    // format display of fppg to fixed number of decimal places
    _player1_fppg.text = [NSString stringWithFormat:@"%.3f", _randomPlayer1.fppg];
    _player2_fppg.text = [NSString stringWithFormat:@"%.3f", _randomPlayer2.fppg];
    
    _player1_fppg.alpha = 1;
    _player2_fppg.alpha = 1;
    
    _choiceResult.alpha = 1;
    
    if (_currentGameScore<_maxGameScore) {
        [_btnNewSelection setTitle:@"Next" forState:UIControlStateNormal];
        _btnNewSelection.alpha = 1;
    } else {
        _gameInstruction.text = @"CONGRATULATIONS!";
        _gameInProgress = FALSE;
        [_btnNewSelection setTitle:@"Play Again" forState:UIControlStateNormal];
        _btnNewSelection.alpha = 1;
    }
}


- (void)showGameScore {
    _gameScore.text = [NSString stringWithFormat:@"%i", _currentGameScore];
}



-(void)prepareForNewGame {
    
    _gameInstruction.text = @"WHO HAS THE HIGHER RATING?";
    _currentGameScore = 0;
    
    _gameInProgress = TRUE;
    
    [self showGameScore];
}


-(void)prepareForNewPlayers {
    
    _randomPlayer1 = nil;
    _randomPlayer2 = nil;
    
    _player1_fppg.text = @"";
    _player2_fppg.text = @"";
    _choiceResult.text = @"";
    
    _player1_tick.alpha = 0;
    _player2_tick.alpha = 0;
    
    _player1_fppg.alpha = 0;
    _player2_fppg.alpha = 0;
    _choiceResult.alpha = 0;
    _btnNewSelection.alpha = 0;
}


#pragma mark - Button Methods

- (IBAction)choosePlayer1 {
    
    if (_awaitingChoice) {
        _awaitingChoice = FALSE;
        
        BOOL success = (_randomPlayer1.fppg > _randomPlayer2.fppg);
        
        if (success) {
            _player1_tick.image = [UIImage imageNamed:@"icon_tick.png"];
        } else {
            _player1_tick.image = [UIImage imageNamed:@"icon_cross.png"];
        }
        _player1_tick.alpha = 1;
        
        [self showResults:success];
        
    }
}

- (IBAction)choosePlayer2 {
    
    if (_awaitingChoice) {
        _awaitingChoice = FALSE;
        
        BOOL success = (_randomPlayer2.fppg > _randomPlayer1.fppg);
        
        if (success) {
            _player2_tick.image = [UIImage imageNamed:@"icon_tick.png"];
        } else {
            _player2_tick.image = [UIImage imageNamed:@"icon_cross.png"];
        }
        _player2_tick.alpha = 1;
        
        [self showResults:success];
        
    }
}

- (IBAction)nextSelection {
    
    if (!_gameInProgress) {
        [self startNewGame];
        
    } else if (!_awaitingChoice) {
        _awaitingChoice = TRUE;
        [self selectRandomPlayers_withNoDraw];
    }
}




#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
