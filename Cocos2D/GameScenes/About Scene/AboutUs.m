//
//  About.m
//  AngryPanda
//
//  Created by Ricky Wang on 3/21/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutUs.h"
#import "SceneManager.h"


@implementation AboutUs



+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	AboutUs *layer = [AboutUs node];
	[scene addChild: layer];
	return scene;
}


-(id)init{
    if((self = [super init])){
        [self setMenuLocation];
        [self addBg];
        [self addMenuBackground];
        [self addBackItem];
        [self addTextLabel];
    }
    return self;
    
}

-(void)setMenuLocation {
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    backMenuLocation = ccp(screenSize.width*0.85,screenSize.height*0.85);
}

-(void)addBg {
    CGSize size = [CCDirector sharedDirector].winSize;
    bg = [CCSprite spriteWithFile:@"bg_common-ipad.png"];
    bg.position = ccp(size.width/2,size.height/2);
    [self addChild:bg z:-1];
}

-(void)addMenuBackground {
    CGSize size = [CCDirector sharedDirector].winSize;
    CCSprite *menuBackground = [CCSprite spriteWithFile:@"rollbg-ipad.png"];
    menuBackground.opacity = 50;
    menuBackground.position = ccp(size.width/2,size.height*0.5);
    [self addChild:menuBackground z:0];
}

-(void)backButtonPressed {
    [backButton runAction:[CCRotateBy actionWithDuration:0.5 angle:360]];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(backToStart)] ,nil]];
}


-(void)addBackItem {
    backButton = [CCMenuItemImage itemWithNormalImage:@"button_back-ipad.png" selectedImage:nil target:self selector:@selector(backButtonPressed)];
    CCMenu *menuButton = [CCMenu menuWithItems:backButton,  nil];
    menuButton.position = backMenuLocation;
    [self addChild:menuButton z:1];
}

-(void)backToStart{
    [SceneManager goStartGame];
}


-(void)addTextLabel {
    CGSize screenSize =[CCDirector sharedDirector].winSize;
    
    //title
    CCSprite *gameTitle = [CCSprite spriteWithFile:@"bg_gametitle-ipad.png"];
    gameTitle.position = ccp(screenSize.width*0.5,screenSize.height*0.5);
    gameTitle.scale = 1.0;
    
    id titleAction = [CCSequence actions:[CCMoveTo actionWithDuration:1.0f position:ccp(screenSize.width*0.5,screenSize.height*0.7)],[CCMoveTo actionWithDuration:1.0f position:ccp(screenSize.width*0.5,screenSize.height*0.8)],[CCMoveTo actionWithDuration:1.0f position:ccp(screenSize.width*0.5,screenSize.height*0.7)], nil];
    
    [gameTitle runAction:titleAction];
    [self addChild:gameTitle z:2];
    
    //copy right
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"@Copyright 2013 Cocos2d Learning"  fontName:@"ChalkboardSE-Bold" fontSize:25];
    label1.position =ccp(screenSize.width/2,screenSize.height*0.5);
    label1.color = ccc3(16,174,231);
    [self addChild:label1 z:2];
    
    //Designed
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"Designed by Cococs2d brother"  fontName:@"ChalkboardSE-Bold" fontSize:25];
    label2.position =ccp(screenSize.width/2,screenSize.height*0.4);
     label2.color = ccc3(16,174,231);
    [self addChild:label2 z:2];
    
    //arts
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Arts by Cococs2d sister" fontName:@"ChalkboardSE-Bold" fontSize:25];
    label3.position =ccp(screenSize.width/2,screenSize.height*0.3);
     label3.color = ccc3(16,174,231);
    [self addChild:label3 z:2];
    
    //music
    CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"Music by Cococs2d cat" fontName:@"ChalkboardSE-Bold" fontSize:25];
    label4.position =ccp(screenSize.width/2,screenSize.height*0.2);
    label4.color = ccc3(16,174,231);
    [self addChild:label4 z:2];
}

@end
