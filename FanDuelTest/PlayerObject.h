//
//  PlayerObject.h
//  PlayerObject Model
//
//  Created by Mark Bonsor on 03/04/2018.
//

#import <Foundation/Foundation.h>

@interface PlayerObject : NSObject {
	
}

-(instancetype)initWithId:(int)player_id
               First_Name:(NSString *)first_name
                Last_Name:(NSString *)last_name
                     FPPG:(float)fppg
                ImageDict:(NSDictionary *)imageDict;

@property (nonatomic) int player_id;
@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic) float fppg;
@property (nonatomic, strong) NSDictionary *imageDict;

@property (nonatomic, strong) NSString *defaultImageURL;




@end


