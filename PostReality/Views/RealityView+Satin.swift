//
//  RealityView+Satin.swift
//  Really
//
//  Created by Reza Ali on 7/19/22.
//

import ARKit
import Foundation
import Metal
import MetalKit
import MetalPerformanceShaders
import ModelIO
import RealityKit
import Satin
import simd

extension RealityView {
    func getOrientation() -> UIInterfaceOrientation? {
        return window?.windowScene?.interfaceOrientation
    }
        
    func setupPostProcessor(_ context: Context) {
        postMaterial = PostMaterial(pipelinesURL: pipelinesURL)
        postProcessor = PostProcessor(context: context, material: postMaterial)
    }
    
    func updateSatinContext(context: ARView.PostProcessContext) {
        if _updateContext {
            setupPostProcessor(Context(context.device, 1, context.compatibleTargetTexture!.pixelFormat))
            _updateContext = false
        }
    }
    
    func updateSize(context: ARView.PostProcessContext) {
        postProcessor.resize((Float(context.sourceColorTexture.width), Float(context.sourceColorTexture.height)))
    }
    
    func updateSatin(context: ARView.PostProcessContext) {
        updateSatinContext(context: context)
        updateSize(context: context)
        
        let time = Float(context.time)
        let st = sin(time)
        let ct = cos(time)
        
        postMaterial.set("Color", [abs(st + ct), abs(ct), abs(st), 1.0])
        
        postMaterial.sourceTexture = context.sourceColorTexture
        postProcessor.draw(
            renderPassDescriptor: MTLRenderPassDescriptor(),
            commandBuffer: context.commandBuffer,
            renderTarget: context.compatibleTargetTexture!
        )
    }
}
