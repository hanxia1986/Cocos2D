//
//  HelloWorldLayer.m
//  DatabaseTest
//
//  Created by eseedo on 9/23/12.
//  Copyright eseedo 2012. All rights reserved.
//


// Import the interfaces
#import "ChallengeGameScene.h"
#import "SimpleAudioEngine.h"
#import "SceneManager.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"


#import "QuestionDatabase.h"
#import "QuestionDetails.h"
#import "Constants.h"

#import "GameData.h"
#import "PauseLayer.h"



@implementation ChallengeGameScene
@synthesize uniqueId = _uniqueId;
@synthesize type = _type;
@synthesize questionIndex = _questionIndex;


+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	ChallengeGameScene *layer = [ChallengeGameScene node];
	[scene addChild: layer];
	return scene;
}

#pragma mark- menu locations
-(void)setMenuLocation{
    screenSize = [CCDirector sharedDirector].winSize;
    
    storeButtonLocation = ccp(screenSize.width*0.1,screenSize.height*0.92);
    
    bgLocation = ccp(screenSize.width*0.5,screenSize.height*0.5);
    
    pauseButtonLocation = ccp(screenSize.width*0.87,screenSize.height*0.88);
    
    zeroLocation = ccp(0,0);
    
    questionLocation = ccp(screenSize.width*0.5,screenSize.height*0.65);
    
    countDownLabelLocation = ccp(screenSize.width*0.15,screenSize.height*0.45);
    
    
    currentQuestionNumberLabelLocation = ccp(screenSize.width*0.5,screenSize.height*0.85);
    
    quizFramePosition = ccp(screenSize.width*0.5,screenSize.height*0.6);
    
    userAnswerFeedbackLocation = ccp(screenSize.width*0.75,screenSize.height*0.5);
    
    answer1Location = ccp(screenSize.width*0.5,screenSize.height*0.33);
    answer2Location = ccp(screenSize.width*0.5,screenSize.height*0.21);
    answer3Location = ccp(screenSize.width*0.5,screenSize.height*0.09);
    
    
    answer1FramePosition = ccp(screenSize.width*0.5,screenSize.height*0.32);
    answer2FramePosition = ccp(screenSize.width*0.5,screenSize.height*0.2);
    answer3FramePosition = ccp(screenSize.width*0.5,screenSize.height*0.08);
    
    answer1IndexLocation = ccp(screenSize.width*0.465,screenSize.height*0.32);
    answer2IndexLocation = ccp(screenSize.width*0.465,screenSize.height*0.2);
    answer3IndexLocation = ccp(screenSize.width*0.465,screenSize.height*0.08);
    
    happyBubsySpritePosition = ccp(screenSize.width*0.85,screenSize.height*0.5);
}

#pragma mark- background
-(void)addBackground {
    bg = [CCSprite spriteWithFile:@"bg_common-ipad.png"];
    bg.position = bgLocation;
    [self addChild:bg z:-1];
}

//add pause menu
-(void)addPauseMenu {
    pauseMenuItem = [CCMenuItemImage itemWithNormalImage:@"button_pause-ipad.png" selectedImage:nil target:self selector:@selector(pauseButtonPressed)];
    pauseMenuItem.position = pauseButtonLocation;
    pauseMenuItem.scale = 0.8;
    CCMenu *menu = [CCMenu menuWithItems:pauseMenuItem, nil];
    menu.position = ccp(0,0);
    [self addChild:menu];
}

-(void)pauseButtonPressed {
    [pauseMenuItem runAction:[CCRotateBy actionWithDuration:0.5 angle:360]];
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(pauseGame)] ,nil]];
}

-(void)pauseGame {
    ccColor4B c = {0,0,0,0};
    [PauseLayer layerWithColor:c delegate:self];
}

-(void)addCartoonAvatar {
    thinkingface = [CCSprite spriteWithFile:@"thinkingface-ipad.png"];
    thinkingface.position = happyBubsySpritePosition;
    [self addChild:thinkingface z:2];
    
}

-(void)updateCartoonAvatar {
    if(thinkingface!=nil){
        [self removeChild:thinkingface cleanup:YES];
        thinkingface = nil;
    }
    
    if(isUserCorrect == YES) {
        smilingface = [CCSprite spriteWithFile:@"smilingface-ipad.png"];
        smilingface.position = happyBubsySpritePosition;
        [self addChild:smilingface z:2];
        
    }else if(isUserCorrect ==NO) {
        sadface = [CCSprite spriteWithFile:@"sadface-ipad.png"];
        sadface.position = happyBubsySpritePosition;
        [self addChild:sadface z:2];
    }
}

-(void)addAnswerIndexLabel {
    answer1index = [CCSprite spriteWithFile:@"answer1_index-ipad.png"];
    answer2index = [CCSprite spriteWithFile:@"answer2_index-ipad.png"];
    answer3index = [CCSprite spriteWithFile:@"answer3_index-ipad.png"];
    
    //set positions
    answer1index.position = answer1IndexLocation;
    answer2index.position = answer2IndexLocation;
    answer3index.position = answer3IndexLocation;
    
    //add to layer
    [self addChild:answer1index z:3];
    [self addChild:answer2index z:3];
    [self addChild:answer3index z:3];
    
    
    
}

//add anwser munu bg
-(void)addAnswerMenu {
    if(answerMenuItem1Selected == NO){
        possibleAnswer1MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerInitialframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem1Selected)];
    }else {
        possibleAnswer1MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerSelectedframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem1Selected)];
    }
    
    if(answerMenuItem2Selected == NO){
        possibleAnswer2MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerInitialframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem2Selected)];
    }else {
        possibleAnswer2MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerSelectedframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem2Selected)];
    }
    
    if(answerMenuItem3Selected == NO){
        possibleAnswer3MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerInitialframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem3Selected)];
    }else {
        possibleAnswer3MenuItem = [CCMenuItemImage itemWithNormalImage:@"answerSelectedframe-ipad.png" selectedImage:nil target:self selector:@selector(answerMenuItem3Selected)];
    }
    
    
    possibleAnswer1MenuItem.position=  answer1FramePosition;
    possibleAnswer2MenuItem.position = answer2FramePosition;
    possibleAnswer3MenuItem.position = answer3FramePosition;
    
    possibleAnswerMenu = [CCMenu menuWithItems:possibleAnswer1MenuItem,possibleAnswer2MenuItem,possibleAnswer3MenuItem, nil];
    possibleAnswerMenu.position = zeroLocation;
    
    [self addChild:possibleAnswerMenu z:0];
}


//answer A
-(void)answerMenuItem1Selected{
    selectedAnswerIndex = 1;
    answerMenuItem1Selected = YES;
    answerMenuItem2Selected = NO;
    answerMenuItem3Selected = NO;
    
    if(possibleAnswerMenu !=nil){
        [self removeChild:possibleAnswerMenu cleanup:YES];
        possibleAnswerMenu = nil;
        [self addAnswerMenu];
    }
    
    [self judgeCorrectOrWrong];
}

//answer B
-(void)answerMenuItem2Selected{
    selectedAnswerIndex = 2;
    answerMenuItem2Selected = YES;
    answerMenuItem1Selected = NO;
    answerMenuItem3Selected = NO;
    
    if(possibleAnswerMenu !=nil){
        [self removeChild:possibleAnswerMenu cleanup:YES];
        possibleAnswerMenu = nil;
        [self addAnswerMenu];
        
    }
    
    [self judgeCorrectOrWrong];
}

//answer C
-(void)answerMenuItem3Selected {
    selectedAnswerIndex = 3;
    answerMenuItem3Selected = YES;
    answerMenuItem1Selected = NO;
    answerMenuItem2Selected = NO;

    if(possibleAnswerMenu !=nil){
        [self removeChild:possibleAnswerMenu cleanup:YES];
        possibleAnswerMenu = nil;
        [self addAnswerMenu];
        
    }

    [self judgeCorrectOrWrong];
}


//add quiz bg
-(void)addQuizFrame{
   CCSprite * quizFrame = [CCSprite spriteWithFile:@"quizframe-ipad.png"];
    quizFrame.position = quizFramePosition;
    [self addChild:quizFrame z:1];
}

//添加当前题目的序号
-(void)addCurrentQuestionIndex {
    NSString *questionIndex = [NSString stringWithFormat:@"Question:%d /%d",currentQuestionIndex,totalQuestionNumberOfCurrentLevel];
    CCLabelTTF *currentQuestionIndexLabel = [CCLabelTTF labelWithString:questionIndex fontName:@"ChalkboardSE-Bold" fontSize:30];
    currentQuestionIndexLabel.position = currentQuestionNumberLabelLocation;
    currentQuestionIndexLabel.color =  ccc3(0,153,68);
    [self addChild:currentQuestionIndexLabel z:1];
}

//添加倒计时的时间计数
-(void)addCountDownLabel {
    NSString *countdown = [NSString stringWithFormat:@"%d",leftTimeForThisQuestion];
    countdownLabel = [CCLabelTTF labelWithString:countdown fontName:@"ChalkboardSE-Bold" fontSize:30];
    countdownLabel.position = countDownLabelLocation;
    countdownLabel.color = ccc3(255,0,0);
    [self addChild:countdownLabel z:1];
}

//更新标签
-(void)updateCountDownLabel{
    if(countdownLabel!=nil){
        [self removeChild:countdownLabel cleanup:YES];
        countdownLabel = nil;
        [self addCountDownLabel];
    }
}


//对当前题目进行倒计时
-(void)updateCountDown:(ccTime)dt{
    
    //如果剩余时间少于1，则当前题目失败，并跳转到下一题目
    if(leftTimeForThisQuestion <1) {
        numberOfAnsweredQuestions ++;
        numberOfWrongAnswers ++;
        userLife --;
        isUserCorrect = NO;
        [self updateCartoonAvatar];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(gameLogic)] ,nil]];
    }
    //如果剩余时间大于1，则进行以下处理
    if(leftTimeForThisQuestion >=1){

        //剩余时间减少
        leftTimeForThisQuestion --;
        
        //倒计时的标签更新
        [self updateCountDownLabel];
    }
   
}

#pragma mark- game data
-(void)readGameData {
    //生成单例对象
    GameData *data = [GameData sharedData];
    
    //设置倒计时计数为15秒
    leftTimeForThisQuestion = CountDownTimeForEachQuestion;
    
    //当前关卡的题目编号
    currentQuestionIndex = data.currentQuestionIndex;
    
    if(currentQuestionIndex ==0){
        currentQuestionIndex =1;
    }
    
    //剩余道具数量
    if(data.notFirstTimePlayThisGame == NO){
        //剩余问题数量的初始值为问题总数

        data.numberOfUnusedQuestions = TotalNumberOfQuestionInDatabase;
        numberOfLeftQuestions = data.numberOfUnusedQuestions;
        
        //允许错误的初始值
        userLife = MaximumNumberOfWrongAnswer +1;
        
        
    }else{
        
        userLife = data.userLife;
        numberOfLeftQuestions = data.numberOfUnusedQuestions;
        
        
    }
    

    
    data.notFirstTimePlayThisGame = YES;
    
    //题目相关
    numberOfAnsweredQuestions = data.numberOfAnsweredQuestionOfCurrentLevel;
    numberOfCorrectAnswers =  data.numberOfCorrectAnswerOfCurrentLevel;
    numberOfWrongAnswers = data.numberOfWrongAnswerOfCurrentLevel;
    
    //关卡相关
    levelNumber = data.selectedLevel;
    
    switch (levelNumber) {
        case 1:
            totalQuestionNumberOfCurrentLevel = Level1QuestionNumber;
            break;
        case 2:
            totalQuestionNumberOfCurrentLevel = Level2QuestionNumber;
            break;
        case 3:
            totalQuestionNumberOfCurrentLevel = Level3QuestionNumber;
            break;
        case 4:
            totalQuestionNumberOfCurrentLevel = Level4QuestionNumber;
            break;
        case 5:
            totalQuestionNumberOfCurrentLevel = Level5QuestionNumber;
            break;
        default:
             totalQuestionNumberOfCurrentLevel = Level1QuestionNumber;
            break;
    }
    
}

#pragma mark- load database
-(void)readDatabase {
   questionIndexOfDatabase = (arc4random()%TotalNumberOfQuestionInDatabase)+1;
   preciseDetails = [[QuestionDatabase database] questionDetails:questionIndexOfDatabase];
}


#pragma mark- question detail
-(void)loadQuestionDetails {
    screenSize = [CCDirector sharedDirector].winSize;
    CGSize questionTitleSize = CGSizeMake(screenSize.width*0.6, screenSize.height*0.29);
    
    if (preciseDetails != nil) {
        questionTitle = [CCLabelTTF labelWithString:preciseDetails.title fontName:@"ChalkboardSE-Bold" fontSize:28 dimensions:questionTitleSize hAlignment:kCCTextAlignmentLeft   vAlignment:kCCVerticalTextAlignmentCenter lineBreakMode:UILineBreakModeWordWrap];
    }
    else {
        questionTitle = [CCLabelTTF labelWithString:@"oops，no more questions :)" fontName:@"ChalkboardSE-Bold" fontSize:28];
    }
    questionTitle.position = questionLocation;
    
    [self addChild:questionTitle z:3];
}



#pragma mark- load answers
-(void)loadAnswers {
    if(preciseDetails !=nil){
        
        correctAnswerIndex = (arc4random()%3)+1;
        
        if(correctAnswerIndex ==1) {
            
            possibleAnswer1 = [CCLabelTTF labelWithString:preciseDetails.correctAnswer fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer1.color = ccc3(0, 0, 0);
            
            possibleAnswer2 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer2 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft  vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer2.color = ccc3(0, 154, 224);
            
            possibleAnswer3 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer3 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer3.color = ccc3(0, 154, 224);
            
            
        }
        else if(correctAnswerIndex ==2){
            
            possibleAnswer1 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer2 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer1.color = ccc3(0, 154, 224);
            
            possibleAnswer2 = [CCLabelTTF labelWithString:preciseDetails.correctAnswer fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer2.color = ccc3(0, 0, 0);
            
            possibleAnswer3 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer3 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(430, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer3.color = ccc3(0, 154, 224);
            
        }
        else if(correctAnswerIndex ==3){
            
            possibleAnswer1 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer3 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer1.color = ccc3(0, 154, 224);
            
            possibleAnswer2 = [CCLabelTTF labelWithString:preciseDetails.possibleAnswer2 fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer2.color = ccc3(0, 154, 224);
            
            possibleAnswer3 = [CCLabelTTF labelWithString:preciseDetails.correctAnswer fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft vAlignment:UITextAlignmentCenter lineBreakMode:UILineBreakModeCharacterWrap];
            possibleAnswer3.color = ccc3(0, 0, 0);
            
        }
        
        
        
    }else{
        possibleAnswer1 = [CCLabelTTF labelWithString:@"oops, no possible answer" fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft  lineBreakMode:UILineBreakModeCharacterWrap];
        
        possibleAnswer2 = [CCLabelTTF labelWithString:@"come on, go check it" fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft  lineBreakMode:UILineBreakModeCharacterWrap];
        
        possibleAnswer3 = [CCLabelTTF labelWithString:@"come on, no more answers" fontName:@"ChalkboardSE-Bold" fontSize:16 dimensions:CGSizeMake(480, 80) hAlignment:UITextAlignmentLeft  lineBreakMode:UILineBreakModeCharacterWrap];
        
    }
    
    possibleAnswer1.position = answer1Location;
    possibleAnswer2.position = answer2Location;
    possibleAnswer3.position = answer3Location;
    
//    possibleAnswer1.color = ccc3(0, 154, 224);
//    possibleAnswer2.color = ccc3(0, 154, 224);
//    possibleAnswer3.color = ccc3(0, 154, 224);
    
    [self addChild:possibleAnswer1 z:5];
    [self addChild:possibleAnswer2 z:5];
    [self addChild:possibleAnswer3 z:5];
    
    
}

#pragma mark- judge corrct or wrong
-(void)judgeCorrectOrWrong {
    if(selectedAnswerIndex == correctAnswerIndex) {
        isUserCorrect = YES;
        numberOfAnsweredQuestions ++;
        numberOfCorrectAnswers ++;
        
    }else if(selectedAnswerIndex != correctAnswerIndex) {
        isUserCorrect = NO;
        numberOfAnsweredQuestions ++;
        numberOfWrongAnswers ++;
        userLife --;
    }

    //无论结果如何，需要让游戏延迟0.5秒钟，然后调用游戏结束逻辑
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(gameLogic)] ,nil]];
    
    
}

//游戏通用逻辑判断
-(void)gameLogic {
    if(numberOfWrongAnswers > MaximumNumberOfWrongAnswer){
        //当前关卡失败，结束当前关卡
        CCLOG(@"当前关卡失败");
        [self endGameScene:kEndReasonLose];
    }else if(numberOfAnsweredQuestions >= totalQuestionNumberOfCurrentLevel){
        //当前关卡通过，结束当前关卡
        CCLOG(@"当前关卡通过");
        [self endGameScene:kEndReasonWin];
        
    }else {
        //切换到下一题
        CCLOG(@"切换到第%d题",numberOfAnsweredQuestions+1);
        
        
        [self changeToNextQuestion];
        
    }
    
    
    
}

//当前关卡结束
-(void)endGameScene:(EndReason)endReason {
    if(endReason == kEndReasonWin){
        levelClear = YES;
    }else{
        levelClear = NO;
    }
    //保存当前关卡的相关结果
    [self saveGameData];

    if(levelNumber == 5 &&levelClear) {
        [SceneManager goChallengeFinalResult];
    }else {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],[CCCallFunc actionWithTarget:self selector:@selector(showLevelResult)] ,nil]];
    }
    
}

//切换到关卡结果界面
-(void)showLevelResult {
    [SceneManager gochallengeLevelResult];
}

//切换到下一题
-(void)changeToNextQuestion{
    currentQuestionIndex ++;
    
    //游戏数据保存
    GameData *data = [GameData sharedData];
    
    //题目相关
    data.numberOfAnsweredQuestionOfCurrentLevel =  numberOfAnsweredQuestions;
    data.numberOfWrongAnswerOfCurrentLevel = numberOfWrongAnswers;
    data.numberOfCorrectAnswerOfCurrentLevel = numberOfCorrectAnswers;
    
    data.currentQuestionIndex = currentQuestionIndex;
    
    //更新道具数量
    
    data.userLife = userLife;
    
    //重新加载当前界面
    
    [SceneManager goChallengeGameScene];
}

//保存当前关卡的游戏结果

-(void)saveGameData{
    
    GameData *data = [GameData sharedData];
    
    //题目相关
    
    data.numberOfAnsweredQuestionOfCurrentLevel = 0;
    data.numberOfWrongAnswerOfCurrentLevel = 0;
    data.numberOfCorrectAnswerOfCurrentLevel = 0;
    data.currentQuestionIndex = 1;
    data.userLife = 3;
    
    
    //关卡信息
    
    data.isCurrentLevelPassed = levelClear;
    
    if(numberOfWrongAnswers ==0){
        data.currentLevelStar =3;
    }else if(numberOfWrongAnswers ==1){
        data.currentLevelStar = 2;
    }else if(numberOfWrongAnswers ==2){
        data.currentLevelStar = 1;
    }else if(numberOfWrongAnswers >=3){
        data.currentLevelStar = 0;
    }
}


#pragma mark- init
-(id) init {
	if( (self=[super init]) ) {
        [self setMenuLocation];
        [self readGameData];
        [self readDatabase];
        [self loadQuestionDetails];
        [self loadAnswers];
        [self addBackground];

        [self addPauseMenu];
        
        [self addAnswerIndexLabel];
        
        //add answer mune bg
        [self addAnswerMenu];
        
        //add quiz mune bg
        [self addQuizFrame];
        
        //添加当前问题的序号
        [self addCurrentQuestionIndex];
        
        //添加倒计时计数
        [self addCountDownLabel];

        //添加卡通形象
        [self addCartoonAvatar];
        
        //实时更新游戏状态
        
        //开始倒计时
        [self schedule:@selector(updateCountDown:) interval:1];
	}
	return self;
}


#pragma mark- PauseLayer Delegate
-(void)pauseLayerDidPause {
    NSLog(@"Delegate for Pause Layer:DidPause");
}

-(void)pauseLayerDidUnpause {
    NSLog(@"Delegate for Pause Layer:Continue");
}

@end
