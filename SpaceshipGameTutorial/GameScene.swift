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
//    var lastUpdateTime : NSTimeInterval
//    var dt : NSTimeInterval
//    var lastMissileAdded : NSTimeInterval
    
    let shipCategory = 0x1 << 1
    let obstacleCategory = 0x1 << 2
    
    var backgroundSpeed : CGFloat = 3.0
    
    // static vector math methods and constants
//    static const float BG_VELOCITY = 100.0; //Velocity with which our background is going to move
//    static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b) {
//        return CGPointMake(a.x + b.x, a.y + b.y);
//    }
//    
//    static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b) {
//        return CGPointMake(a.x * b, a.y * b);
//    }

    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.backgroundColor = SKColor.whiteColor()
        self.initializingScrollingBackground()
        self.addShip()
        
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
        self.moveBackground()
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
            bg.position = CGPoint(x: index * Int(bg.size.width), y: 20)
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            self.addChild(bg)
        }
    }
    
    func moveBackground() {
        self.enumerateChildNodesWithName("background", usingBlock: { (node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x - self.backgroundSpeed, y: bg.position.y)
                
                // Checks if bg node is completely scrolled off the screen, if yes, then puts it at the end of the other node.
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPointMake(bg.position.x + bg.size.width * 2, bg.position.y)
                }
            }
        })
    }
    
}

/*


- (void)moveBg
{
[self enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
{
SKSpriteNode * bg = (SKSpriteNode *) node;
CGPoint bgVelocity = CGPointMake(-BG_VELOCITY, 0);
CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
bg.position = CGPointAdd(bg.position, amtToMove);

//Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
if (bg.position.x <= -bg.size.width)
{
bg.position = CGPointMake(bg.position.x + bg.size.width*2,
bg.position.y);
}
}];
}


*/