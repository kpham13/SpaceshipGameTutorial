//
//  GameScene.swift
//  SpaceshipGameTutorial
//
//  Created by Kevin Pham on 11/28/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
  
  var ship = SKSpriteNode()
  var actionMoveUp = SKAction()
  var actionMoveDown = SKAction()
  var lastMissileAdded : NSTimeInterval = 0.0
  
  let shipCategory = 0x1 << 1
  let obstacleCategory = 0x1 << 2
  
  let backgroundVelocity : CGFloat = 3.0
  let missileVelocity : CGFloat = 5.0
  
  override func didMoveToView(view: SKView) {
      /* Setup your scene here */
      self.backgroundColor = SKColor.whiteColor()
      self.initializingScrollingBackground()
      self.addShip()
      self.addMissile()
      
      // Making self delegate of physics world
      self.physicsWorld.gravity = CGVectorMake(0, 0)
      self.physicsWorld.contactDelegate = self
  }
  
  override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      /* Called when a touch begins */
      
      for touch: AnyObject in touches {
          let location = touch.locationInNode(self)
          
          if location.y > ship.position.y {
              if ship.position.y < 300 {
                  ship.runAction(actionMoveUp)
              }
          } else {
              if ship.position.y > 50 {
                  ship.runAction(actionMoveDown)
              }
          }
      }
  }
 
  override func update(currentTime: CFTimeInterval) {
      /* Called before each frame is rendered */
      if currentTime - self.lastMissileAdded > 1 {
          self.lastMissileAdded = currentTime + 1
          self.addMissile()
      }
      
      self.moveBackground()
      self.moveObstacle()
  }
  
  func addShip() {
      // Initializing spaceship node
      ship = SKSpriteNode(imageNamed: "spaceship")
      ship.setScale(0.5)
      ship.zRotation = CGFloat(-M_PI/2)
      
      // Adding SpriteKit physics body for collision detection
      ship.physicsBody = SKPhysicsBody(rectangleOfSize: ship.size)
      ship.physicsBody?.categoryBitMask = UInt32(shipCategory)
      ship.physicsBody?.dynamic = true
      ship.physicsBody?.contactTestBitMask = UInt32(obstacleCategory)
      ship.physicsBody?.collisionBitMask = 0
      ship.name = "ship"
      ship.position = CGPointMake(120, 160)
      
      self.addChild(ship)
      
      actionMoveUp = SKAction.moveByX(0, y: 30, duration: 0.2)
      actionMoveDown = SKAction.moveByX(0, y: -30, duration: 0.2)
  }
  
  func initializingScrollingBackground() {
      for var index = 0; index < 2; ++index {
          let bg = SKSpriteNode(imageNamed: "bg")
          bg.position = CGPoint(x: index * Int(bg.size.width), y: 0)
          bg.anchorPoint = CGPointZero
          bg.name = "background"
          self.addChild(bg)
      }
  }
  
  func moveBackground() {
      self.enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
          if let bg = node as? SKSpriteNode {
              bg.position = CGPoint(x: bg.position.x - self.backgroundVelocity, y: bg.position.y)
              
              // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
              if bg.position.x <= -bg.size.width {
                  bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y)
              }
          }
      })
  }
  
  func addMissile() {
      // Initializing spaceship node
      var missile = SKSpriteNode(imageNamed: "red-missile")
      missile.setScale(0.15)
      
      // Adding SpriteKit physics body for collision detection
      missile.physicsBody = SKPhysicsBody(rectangleOfSize: missile.size)
      missile.physicsBody?.categoryBitMask = UInt32(obstacleCategory)
      missile.physicsBody?.dynamic = true
      missile.physicsBody?.contactTestBitMask = UInt32(shipCategory)
      missile.physicsBody?.collisionBitMask = 0
      missile.physicsBody?.usesPreciseCollisionDetection = true
      missile.name = "missile"
      
      // Selecting random y position for missile
      var random : CGFloat = CGFloat(arc4random_uniform(300))
      missile.position = CGPointMake(self.frame.size.width + 20, random)
      self.addChild(missile)
  }
  
  func moveObstacle() {
      self.enumerateChildNodesWithName("missile", usingBlock: { (node, stop) -> Void in
          if let obstacle = node as? SKSpriteNode {
              obstacle.position = CGPoint(x: obstacle.position.x - self.missileVelocity, y: obstacle.position.y)
              if obstacle.position.x < 0 {
                  obstacle.removeFromParent()
              }
          }
      })
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
      var firstBody = SKPhysicsBody()
      var secondBody = SKPhysicsBody()
      if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
          firstBody = contact.bodyA
          secondBody = contact.bodyB
      } else {
          firstBody = contact.bodyB
          secondBody = contact.bodyA
      }
      
      if (firstBody.categoryBitMask & UInt32(shipCategory)) != 0 && (secondBody.categoryBitMask & UInt32(obstacleCategory)) != 0 {
          ship.removeFromParent()
          let reveal = SKTransition.flipHorizontalWithDuration(0.5)
          let scene = GameOverScene(size: self.size)
          self.view?.presentScene(scene, transition: reveal)
      }
  }

}