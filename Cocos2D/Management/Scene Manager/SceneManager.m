//
//  SceneManager.m
//  DoomsDay2012
//
//  Created by eseedo on 9/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//
//  SceneManager.m
//

#import "SceneManager.h"

#import "StartGameScene.h"
//#import "GameSetting.h"
//#import "GameHelp.h"
#import "AboutUs.h"
#import "MoreApps.h"
#import "ChallengeLevelSelection.h"
#import "ChallengeGameScene.h"
#import "ChallengeLevelResult.h"
//#import "ChallengeFinalResult.h"

//#import "CrazyModeGuide.h"
//#import "CrazyModeGameScene.h"
//#import "CrazyModeResultScene.h"

//#import "GameStore.h"

@interface SceneManager ()

+(void) go: (CCLayer *) layer;
+(CCScene *) wrap: (CCLayer *) layer;

@end

@implementation SceneManager

#pragma mark- switch scene
+(void) go: (CCLayer *) layer {
    CCDirector *director = [CCDirector sharedDirector];
    CCScene *newScene = [SceneManager wrap:layer];
    
    
    if ([director runningScene]) {
        
        [director replaceScene:newScene];
        
        
    }
    else {
        [director runWithScene:newScene];
    }
}

+(void) goStartGame {
    [SceneManager go:[StartGameScene node]];
}


+(void) goAboutUs{
    [SceneManager go:[AboutUs node]];
}

+(void) goChallengeLevelSelect {
    [SceneManager go:[ChallengeLevelSelection node]];
}

+(void) goChallengeGameScene {
    [SceneManager go:[ChallengeGameScene node]];
}

+(void) gochallengeLevelResult {
    [SceneManager go:[ChallengeLevelResult node]];
}

+(void) goMoreApps {
    [SceneManager go:[MoreApps node]];
}
+(CCScene *) wrap: (CCLayer *) layer {
    CCScene *newScene = [CCScene node];
    [newScene addChild: layer];
    return newScene;
}

@end
