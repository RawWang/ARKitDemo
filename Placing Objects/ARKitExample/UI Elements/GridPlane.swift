//
//  GridPlane.swift
//  ARKitExample
//
//  Created by Raw on 21/8/17.
//  Copyright © 2017年 Apple. All rights reserved.
//

import ARKit

class GridPlane: SCNNode {
    var anchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    init(withAnchor anchor: ARPlaneAnchor){
        super.init()
        
        self.anchor = anchor
        planeGeometry = SCNPlane.init(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        //贴图
        let material = SCNMaterial()
        let img = UIImage.init(named: "grid")
        material.diffuse.contents = img
        material.lightingModel = .physicallyBased
        planeGeometry.materials = [material]
        
        let planeNode = SCNNode.init(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        
        //SceneKit 里的Plane默认为垂直，所以需要翻转90度
        planeNode.transform = SCNMatrix4MakeRotation(Float(-.pi / 2.0), 1.0, 0.0, 0.0)
        
        setTextureScale()
        addChildNode(planeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(anchor: ARPlaneAnchor) {
        planeGeometry.width = CGFloat(anchor.extent.x)
        planeGeometry.height = CGFloat(anchor.extent.z)
        
        position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
        setTextureScale()
    }
    
    func setTextureScale() {
        let width = planeGeometry.width
        let height = planeGeometry.height
        
        let material = planeGeometry.materials.first
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
        material?.diffuse.wrapS = .repeat
        material?.diffuse.wrapT = .repeat
    }
}
