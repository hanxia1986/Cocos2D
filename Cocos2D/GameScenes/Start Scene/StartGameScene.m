

#import "StartGameScene.h"
#import "SceneManager.h"



@implementation StartGameScene
+(id)scene {
    CCScene *scene =[CCScene node];
    StartGameScene *layer = [StartGameScene node];
    [scene addChild:layer];
    return scene;
}

-(id)init {
    if((self  =[super init])) {

        [self setMenuLocation];
        
        [self addGameTitle];
        
        [self addBackground];
        
        [self addGameMenu];
    }
    return self;
}

#pragma mark- addGameMenu
-(void)addGameMenu {
    [self addStartItem];
    [self addMoreItem];
    [self addAboutItem];
}

-(void)addStartItem {
    startChallengeItem = [CCMenuItemImage itemWithNormalImage:@"button_start-ipad.png" selectedImage:nil target:self selector:@selector(startItemClick)];
    startChallengeItem.position = startChallengeMenuLocation;
    CCMenu *menu =[CCMenu menuWithItems:startChallengeItem, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:2];
}

-(void)addMoreItem {
    moreItem = [CCMenuItemImage itemWithNormalImage:@"button_more-ipad.png" selectedImage:nil target:self selector:@selector(moreItemClick)];
    moreItem.position =moreMenuLocation;
    CCMenu *menu =[CCMenu menuWithItems:moreItem, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:2];
}

-(void)addAboutItem {
    //menu
    aboutItem = [CCMenuItemImage itemWithNormalImage:@"button_aboutus-ipad.png" selectedImage:nil target:self selector:@selector(aboutItemClick)];
    aboutItem.position =aboutMenuLocation;
    
    //CCMenu:Layer
    CCMenu *menu =[CCMenu menuWithItems:aboutItem, nil];
    menu.position = CGPointZero;
    [self addChild:menu z:2];
    
}

#pragma mark - action methods
- (void)startItemClick {
    [SceneManager goChallengeLevelSelect];
}

- (void)moreItemClick {
    [SceneManager goMoreApps];
}

- (void)aboutItemClick {
    [SceneManager goAboutUs];
}

#pragma mark- addBackground
-(void)addBackground {
    bg = [CCSprite spriteWithFile:@"bg_startscene-ipad.png"];
    bg.position = bgLocation;
    [self addChild:bg z:-1];
}

#pragma mark- addGameTitle
-(void)addGameTitle {
    gameTitle = [CCSprite spriteWithFile:@"bg_gametitle-ipad.png"];
    gameTitle.position = titleLocation;
    [self addChild:gameTitle z:0];
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Challenge" fontName:@"ChalkboardSE-Bold" fontSize:90];
    label.position = titleLabelLocation;
    label.color = ccc3(16,174,231);
    
    [self addChild:label z:0];
}

#pragma mark- setMenuLocation
-(void)setMenuLocation {
    [self getScreenSize];
    aboutMenuLocation = ccp(screenSize.width*0.15,screenSize.height*0.25);
    startChallengeMenuLocation = ccp(screenSize.width*0.4,screenSize.height*0.25);
    moreMenuLocation = ccp(screenSize.width*0.65,screenSize.height*0.25);
    
    titleLocation = ccp(screenSize.width*0.5,screenSize.height*0.7);
    titleLabelLocation = ccp(screenSize.width*0.55,screenSize.height*0.5);
    bgLocation = ccp(screenSize.width*0.5,screenSize.height*0.5);
    
//    soundMenuLocation = ccp(screenSize.width*0.2,screenSize.height *0.5);
    
    
}

#pragma mark- Private Methods
-(void)getScreenSize{
    
    screenSize = [CCDirector sharedDirector].winSize;
}
@end