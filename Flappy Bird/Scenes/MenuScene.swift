import SpriteKit

final class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        createBackground()
        createForeground()
        createTitle()
        createBirdHero()
        createPlayButton()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "play" || node.parent?.name == "play" {
            let scene = GameScene(size: size)
            
            scene.scaleMode = .resizeFill
            
            view?.presentScene(scene, transition: .fade(withDuration: 0.3))
        }
    }
    
    private func createPlayButton() {
        let playButton = SKSpriteNode(color: .systemBlue, size: CGSize(width: 220, height: 70))
        playButton.position = CGPoint(x: frame.midX, y: frame.midY - 80)
        playButton.name = "play"
        addChild(playButton)
        
        let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
        label.text = "PLAY"
        label.fontSize = 34
        label.verticalAlignmentMode = .center
        playButton.addChild(label)
    }
    
    private func createBackground() {
        let texture = AtlasManager.shared.getBackground(for: .DAY)
        let background = SKSpriteNode(texture: texture)
        background.name = "background"
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -100
        
        let textureSize = texture.size()
        let scale = max(size.width / textureSize.width, size.height / textureSize.height)
        
        background.setScale(scale)
        
        addChild(background)
    }
    
    private func createForeground() {
        let texture = AtlasManager.shared.getForground(for: .BASIC)
        let foreground = SKSpriteNode(texture: texture)
        
        foreground.name = "foreground"
        foreground.zPosition = -75
        
        // Scale to fit the width
        let scale = size.width / texture.size().width
        foreground.setScale(scale)
        
        // Position on the bottom of the screen
        foreground.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        foreground.position = CGPoint(x: size.width / 2, y: 0)
        
        addChild(foreground)
    }
    
    private func createBirdHero() {
        let texture = AtlasManager.shared.getYellowBird(with: .MID)
        let bird = SKSpriteNode(texture: texture)
        bird.name = "bird"
        bird.zPosition = -50
        bird.setScale(3.0)
        bird.position = CGPoint(x: frame.midX, y: frame.midY + 100)
        addChild(bird)
    }
    
    private func createTitle() {
        let title = SKLabelNode(fontNamed: "AvenirNext-Bold")
        title.text = "Flappy Bird"
        title.fontSize = 48
        title.fontColor = .white
        title.position = CGPoint(x: size.width / 2, y: size.height * 0.75)
        title.zPosition = 100

        addChild(title)
    }
}

