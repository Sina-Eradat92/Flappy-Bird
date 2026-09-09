import SpriteKit


final class PipePairNode: SKNode {

    init(pipeTexture: SKTexture, gapY: CGFloat, gapHeight: CGFloat, screenWidth: CGFloat) {

        super.init()

        let topPipe = SKSpriteNode(texture: pipeTexture)
        let bottomPipe = SKSpriteNode(texture: pipeTexture)

        let desiredPipeWidth = screenWidth * 0.15
        let scale = desiredPipeWidth / pipeTexture.size().width

        topPipe.setScale(scale)
        bottomPipe.setScale(scale)

        topPipe.zRotation = .pi

        topPipe.position = CGPoint(x: 0, y: gapY + gapHeight / 2 + topPipe.size.height / 2)

        bottomPipe.position = CGPoint(x: 0, y: gapY - gapHeight / 2 - bottomPipe.size.height / 2)

        addChild(topPipe)
        addChild(bottomPipe)

        configurePhysics(pipe: topPipe)
        configurePhysics(pipe: bottomPipe)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configurePhysics(pipe: SKSpriteNode) {
        pipe.physicsBody = SKPhysicsBody(rectangleOf: pipe.size)
        pipe.physicsBody?.isDynamic = false
        pipe.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        pipe.physicsBody?.affectedByGravity = false
        pipe.physicsBody?.allowsRotation = false
    }
}

