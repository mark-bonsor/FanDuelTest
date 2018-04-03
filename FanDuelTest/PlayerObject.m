//
//  PlayerObject.m
//  PlayerObject Model
//
//  Created by Mark Bonsor on 03/04/2018.
//


#import "PlayerObject.h"

@implementation PlayerObject


-(instancetype)initWithId:(int)player_id
               First_Name:(NSString *)first_name
                Last_Name:(NSString *)last_name
                     FPPG:(float)fppg
                ImageDict:(NSDictionary *)imageDict
{
    self = [super init];
    if(self){
        self.player_id = player_id;
        self.first_name = first_name;
        self.last_name = last_name;
        self.fppg = fppg;
        self.imageDict = imageDict;
        
        self.defaultImageURL = [imageDict objectForKey:@"url"];
        
    }
    return self;
}



@end
