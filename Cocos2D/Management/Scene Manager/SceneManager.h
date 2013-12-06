//
//  SceneManager.h
//  DoomsDay2012
//
//  Created by eseedo on 9/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

//
//  SceneManager.h
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SceneManager : NSObject {
    
}

/*  ___Template___________________________________
 
 Step 2 - Add interface scene calling method
 ______________________________________________
 
 +(void) goSceneName;
 
 */

+(void) goStartGame;

+(void) goGameSetting;

+(void) goGameHelp;

+(void) goMoreApps;

+(void) goAboutUs;

+(void) goChallengeLevelSelect;

+(void) goChallengeGameScene;

+(void) gochallengeLevelResult;

+(void) goChallengeFinalResult;

+(void) goCrazyModeGuide;

+(void) goCrazyModeGameScene;

+(void) goCrazyModeResultScene;

+(void) goGameStore;



@end
