import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var bird: BirdNode?
    var pipes: [PipePairNode] = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        
        addBackground()
        addForground()
        addScoreboard()
        addBird()
        pipes.append(spawnPipe())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let bird = bird {
            bird.flap()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        for pipe in pipes {
            pipe.position.x = pipe.position.x - 1
            if pipe.position.x == (size.width / 2) + 30 {
                pipes.append(spawnPipe())
            }
            else if pipe.position.x < -30 {
                pipes.removeFirst()
            }
        }
    }
    
    private func addBackground() {
        let background = AtlasManager.shared.getBackground(for: .DAY)
        let node = SKSpriteNode(texture: background)
        
        node.zPosition = -100
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        let backgroundSize = background.size()
        let scale = max(size.width / backgroundSize.width, size.height / backgroundSize.height)
        node.setScale(scale)
        
        addChild(node)
    }
    
    private func addForground() {
        let forground = AtlasManager.shared.getForground(for: .BASIC)
        let node = SKSpriteNode(texture: forground)
        
        node.position = CGPoint(x: size.width / 2, y: node.size.height / 2)
        node.zPosition = -98
        node.setScale(size.width / forground.size().width)
        
        node.physicsBody = SKPhysicsBody(texture: forground, size: node.size)
        node.physicsBody?.categoryBitMask = PhysicsCategory.ground
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.isDynamic = false
        addChild(node)
    }
    
    private func addScoreboard() {
        
    }
    
    private func addBird() {
        let texture = AtlasManager.shared.getYellowBird(with: .MID)
        bird = BirdNode(texture: texture, sceneSize: size)
        
        if let bird = bird {
            bird.startAnimation()
            
            bird.zPosition = -99
            bird.position = CGPoint(x: frame.midX + 100, y: frame.midY)
            
            addChild(bird)
        }
    }
    
    func spawnPipe() -> PipePairNode {
        let texture = AtlasManager.shared.getPipe(for: .GREEN)
        let pipePair = PipePairNode(pipeTexture: texture, gapY: 500, gapHeight: 120, screenWidth: size.width)
        
        pipePair.position = CGPoint(x: (size.width + texture.size().width / 2) + 10, y: 0)
        pipePair.zPosition = -99
        addChild(pipePair)
        return pipePair
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let mask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch mask {
        case PhysicsCategory.bird | PhysicsCategory.ground:
            gameOver()
            
        case PhysicsCategory.bird | PhysicsCategory.pipe:
            gameOver()
            
        default:
            break
        }
    }
    
    func gameOver() {
        
        bird?.physicsBody?.velocity = .zero
        bird?.physicsBody?.affectedByGravity = false
        
        isPaused = true
    }
}
