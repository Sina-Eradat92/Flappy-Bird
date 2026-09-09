final class GameManager {
    private(set) var state: GameState = .ready
    
    func start() { state = .playing }
    
    func endGame() { state = .gameover }
    
    func reset() { state = .ready }
}

