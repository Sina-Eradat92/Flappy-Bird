import SpriteKit

final class BirdNode: SKSpriteNode {
    
    private let textures: [SKTexture] = [
        AtlasManager.shared.getYellowBird(with: .UP),
        AtlasManager.shared.getYellowBird(with: .MID),
        AtlasManager.shared.getYellowBird(with: .DOWN),
    ]
    
    init(texture: SKTexture, sceneSize: CGSize) {
        super.init(texture: texture, color: .clear, size: texture.size())
        
        let desiredWidth = sceneSize.width * 0.10
        let scale = desiredWidth / texture.size().width
        setScale(scale)
        
        configurePhysics()
    }
    
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePhysics() {
        physicsBody = SKPhysicsBody(circleOfRadius: size.width / 2)
        
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        
        physicsBody?.categoryBitMask = PhysicsCategory.bird
        physicsBody?.collisionBitMask = PhysicsCategory.ground | PhysicsCategory.pipe
        physicsBody?.contactTestBitMask = PhysicsCategory.pipe | PhysicsCategory.ground | PhysicsCategory.score
    }
    
    func flap() {
        physicsBody?.velocity = .zero
        physicsBody?.applyImpulse(CGVector(dx: 0, dy: 7))
    }
    
    func startAnimation() {
        texture = textures.first
        let flap = SKAction.animate(with: textures, timePerFrame: 0.08)
        run(SKAction.repeatForever(flap), withKey: "Flap")
    }
    
    func stopAnimation() {
        removeAction(forKey: "Flap")
    }
    
}
