//
//  GameOverScene.swift
//  SpaceshipGameTutorial
//
//  Created by Kevin Pham on 12/3/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
   
    init(size: CGSize) {
        <#code#>
    }
    
}

//
//-(id)initWithSize:(CGSize)size {
//    if (self = [super initWithSize:size]) {
//        
//        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
//        
//        NSString * message;
//        message = @"Game Over";
//        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        label.text = message;
//        label.fontSize = 40;
//        label.fontColor = [SKColor blackColor];
//        label.position = CGPointMake(self.size.width/2, self.size.height/2);
//        [self addChild:label];
//        
//        NSString * retrymessage;
//        retrymessage = @"Replay Game";
//        SKLabelNode *retryButton = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        retryButton.text = retrymessage;
//        retryButton.fontColor = [SKColor blackColor];
//        retryButton.position = CGPointMake(self.size.width/2, 50);
//        retryButton.name = @"retry";
//        [self addChild:retryButton];
//    }
//    
//    return self;
//    }
//    
//    - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//        UITouch *touch = [touches anyObject];
//        CGPoint location = [touch locationInNode:self];
//        SKNode *node = [self nodeAtPoint:location];
//        
//        if ([node.name isEqualToString:@"retry"]) {
//            //3
//            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
//            GameScene *scene = [GameScene sceneWithSize:self.view.bounds.size];
//            scene.scaleMode = SKSceneScaleModeAspectFill;
//            [self.view presentScene:scene transition: reveal];
//        }
//    }