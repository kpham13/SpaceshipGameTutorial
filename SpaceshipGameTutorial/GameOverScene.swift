//
//  GameOverScene.swift
//  SpaceshipGameTutorial
//
//  Created by Kevin Pham on 11/28/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
   
    override init(size: CGSize) {
        super.init()
        
        // 1
        self.backgroundColor = SKColor.whiteColor()
        
        // 2
        var message = "Game Over"
        
        // 3
        var label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPointMake(self.size.width/2, self.size.height/2)
        self.addChild(label)
        
        // 4
        var replayMessage = "Replay Game"
        var replayButton = SKLabelNode(fontNamed: "Chalkduster")
        replayButton.text = replayMessage
        replayButton.fontColor = SKColor.blackColor()
        replayButton.position = CGPointMake(self.size.width/2, 50)
        replayButton.name = "replay"
        self.addChild(replayButton)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if self.nodeAtPoint(location).name == "replay" {
                var reveal = SKTransition.flipHorizontalWithDuration(0.5)
                let scene : GameScene = GameScene(size: self.view!.bounds.size)
                scene.scaleMode = .AspectFill
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }


}