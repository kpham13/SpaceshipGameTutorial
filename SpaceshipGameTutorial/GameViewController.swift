//
//  GameViewController.swift
//  SpaceshipGameTutorial
//
//  Created by Kevin Pham on 11/28/14.
//  Copyright (c) 2014 Kevin Pham. All rights reserved.
//

import UIKit
import SpriteKit

extension SKNode {
    class func unarchiveFromFile(file : NSString) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file as String, ofType: "sks") {
        
            var sceneData: NSData?
            // Error occurs on the following line:
            do {
                sceneData = try NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)

            } catch _ as NSError {
                return nil
            }
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData!)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {

  override func viewDidLoad() {
      super.viewDidLoad()
      // Presenting scene without using GameScene.sks
      let skView = self.view as! SKView
      let myScene = GameScene(size: skView.frame.size)
      skView.presentScene(myScene)
  }

  override func shouldAutorotate() -> Bool {
      return true
  }

  override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
      if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
          return UIInterfaceOrientationMask.AllButUpsideDown
      } else {
          return UIInterfaceOrientationMask.All
      }
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }

  override func prefersStatusBarHidden() -> Bool {
      return true
  }
  
}