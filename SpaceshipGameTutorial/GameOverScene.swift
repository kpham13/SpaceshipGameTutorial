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
  
  override init(size: CGSize) {
    super.init(size: size)
    self.backgroundColor = SKColor.whiteColor()
    
    let message = "Game over"
    var label = SKLabelNode(fontNamed: "Chalkduster")
    label.text = message
    label.fontSize = 40
    label.fontColor = SKColor.blackColor()
    label.position = CGPointMake(self.size.width/2, self.size.height/2)
    self.addChild(label)
    
    let replayMessage = "Replay Game"
    var replayButton = SKLabelNode(fontNamed: "Chalkduster")
    replayButton.text = replayMessage
    replayButton.fontColor = SKColor.blackColor()
    replayButton.position = CGPointMake(self.size.width/2, 50)
    replayButton.name = "replay"
    self.addChild(replayButton)
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
    for touch: AnyObject in touches {
      let location = touch.locationInNode(self)
      let node = self.nodeAtPoint(location)
      
      if node.name == "replay" {
        let reveal : SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
        let scene = GameScene(size: self.view!.bounds.size)
        scene.scaleMode = .AspectFill
        self.view?.presentScene(scene, transition: reveal)
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}