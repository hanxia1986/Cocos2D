//
//  MoreApps.m
//  Cocos2dChallenge
//
//  Created by Ricky on 2/13/13.
//  Copyright 2013 happybubsy. All rights reserved.
//

#import "MoreApps.h"
#import "SceneManager.h"
#import "GameData.h"
#import "SimpleAudioEngine.h"
#import "Constants.h"


@implementation MoreApps {
    CGPoint iconForSoundToysPosition;
    CGPoint backMenuLocation;
    CCMenuItemImage* backButton;
    CCSprite *bg;
}



+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MoreApps *layer = [MoreApps node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


//设置视觉元素位置
-(void)setMenuLocation{
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    backMenuLocation = ccp(screenSize.width*0.85,screenSize.height*0.85);
    
    iconForSoundToysPosition= ccp(screenSize.width/2,screenSize.height/2);
    
}


//button pressed
-(void)backButtonPressed{
    
    [backButton runAction:[CCRotateBy actionWithDuration:0.5 angle:360]];
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(backToStart)] ,nil]];
}

//返回游戏开始界面
-(void)backToStart {
    [SceneManager goStartGame];
}

//添加返回按钮
-(void)addBackItem {
    backButton = [CCMenuItemImage itemWithNormalImage:@"button_back-ipad.png" selectedImage:nil target:self selector:@selector(backButtonPressed)];
    CCMenu *menuButton = [CCMenu menuWithItems:backButton,  nil];
    menuButton.position = backMenuLocation;
    [self addChild:menuButton z:1];
}

//添加背景图片
-(void)addBg {
    CGSize size = [CCDirector sharedDirector].winSize;
    bg = [CCSprite spriteWithFile:@"bg_common-ipad.png"];
    bg.position = ccp(size.width/2,size.height/2);
    [self addChild:bg z:-1];
}


//icon

-(void)addIconsForOtherApps{
    
    CGSize screenSize = [CCDirector sharedDirector].winSize;
    
    CGSize labelSize = CGSizeMake(screenSize.width*0.5,screenSize.height*0.2);
    
    CCMenuItemImage *iconForSoundToys = [CCMenuItemImage itemWithNormalImage:@"soundtoys-ipad.png" selectedImage:nil target:self selector:@selector(goAppStore:)];
    iconForSoundToys.tag = kAppSoundToys;
    iconForSoundToys.position = iconForSoundToysPosition;
    
    CCMenu *menu = [CCMenu menuWithItems:iconForSoundToys, nil];
    [self addChild:menu z:1];
    
    menu.position = ccp(0,0);
    
    CCLabelTTF *labelForSoundToys = [CCLabelTTF labelWithString:@"Sound Toys, an All in one app to enjoy sound toys worldwide :)" fontName:@"ChalkboardSE-Bold" fontSize:30 dimensions:labelSize hAlignment:kCCTextAlignmentLeft lineBreakMode:UILineBreakModeCharacterWrap];
    labelForSoundToys.position = ccp(iconForSoundToysPosition.x,iconForSoundToysPosition.y*0.4);
    labelForSoundToys.color = ccc3(16,174,231);
    [self addChild:labelForSoundToys z:1];
}

-(void)goAppStore:(id)sender{
    
    CCMenuItemImage *appLinked = (CCMenuItemImage*)sender;
    int linkedAppIndex = appLinked.tag;
    
    if(linkedAppIndex == kAppSoundToys){
        
//        NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=592992159&mt=8"];
        NSURL *url = [NSURL URLWithString:@"http://blog.sina.com.cn/eseedo"];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

//场景初始化


-(id)init {
    if((self = [super init])){
        [self setMenuLocation];
        [self addBg];
        [self addBackItem];
        [self addIconsForOtherApps];
    }
    return self;
}



@end
