//
//  AtlasManager.swift
//  Flappy Bird
//
//  Created by Sina Eradat on 7/13/26.
//

import SpriteKit

class AtlasManager {
    
    enum GameAssest: String {
        case BACKGROUND   = "Background"
        case FORGROUND    = "Forground"
        case PIPES        = "Pipes"
        case YELLOW_BIRD  = "Bird_Yellow"
    }
    
    enum BackgroundType: String {
        case DAY      = "day"
        case NIGHT    = "night"
    }
    
    enum ForgroundType: String {
        case BASIC = "basic"
    }
    
    enum BirdState: String {
        case UP   = "up"
        case MID  = "mid"
        case DOWN = "down"
    }
    
    enum PipeTypes: String {
        case GREEN  = "green"
        case RED    = "red"
    }
    
    private init() {}
    
    static let shared = AtlasManager()
    
    func getTextureAtlas(for gameAsset: GameAssest) -> SKTextureAtlas {
        return SKTextureAtlas(named: gameAsset.rawValue)
    }
    
    func getBackground(for type: BackgroundType) -> SKTexture {
        return SKTextureAtlas(named: GameAssest.BACKGROUND.rawValue).textureNamed(type.rawValue)
    }
    
    func getForground(for type: ForgroundType) -> SKTexture {
        return SKTextureAtlas(named: GameAssest.FORGROUND.rawValue).textureNamed(type.rawValue)
    }
    
    func getPipe(for type: PipeTypes) -> SKTexture {
        return SKTextureAtlas(named: GameAssest.PIPES.rawValue).textureNamed(type.rawValue)
    }
    
    func getYellowBird(with state: BirdState) -> SKTexture {
        return SKTextureAtlas(named: GameAssest.YELLOW_BIRD.rawValue).textureNamed(state.rawValue)
    }
}
