//
//  GameViewController.swift
//  Flappy Bird
//
//  Created by Sina Eradat on 7/8/26.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let view = self.view as? SKView else { return }
        
        let scene = MenuScene(size: view.bounds.size)
        
        scene.scaleMode = .resizeFill
        
        view.presentScene(scene)
        
        view.ignoresSiblingOrder = true
        view.showsFPS = true
        view.showsNodeCount = true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
