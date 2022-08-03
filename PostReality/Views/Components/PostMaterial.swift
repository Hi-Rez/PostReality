//
//  BloomMaterial.swift
//  Really
//
//  Created by Reza Ali on 8/3/22.
//

import Foundation
import Satin
import Metal

class PostMaterial: LiveMaterial {
    var sourceTexture: MTLTexture?
    
    override func bind(_ renderEncoder: MTLRenderCommandEncoder) {
        super.bind(renderEncoder)
        renderEncoder.setFragmentTexture(sourceTexture, index: FragmentTextureIndex.Custom0.rawValue)
    }
}
