//
//  ViewController.swift
//  Play3D
//
//  Created by Vilhelmas on 10/04/2017.
//  Copyright © 2017 Vilhelmas. All rights reserved.
//

import UIKit

import SceneKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sceneView = SCNView(frame: self.view.frame)
        self.view.addSubview(sceneView)
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(x: -5.0, y: 5.0, z: 5.0)
        
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        cameraNode.light = ambientLight
        
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        light.spotInnerAngle = 30.0
        light.spotOuterAngle = 80.0
        light.castsShadow = true
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3(x: 1.5, y: 1.5, z: 1.5)
        
        let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNode = SCNNode(geometry: cubeGeometry)
        
        let cubeGeometryTwo = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNodeTwo = SCNNode(geometry: cubeGeometryTwo)
        cubeNodeTwo.position = SCNVector3(x:0.0, y:1.0, z:0.0)
        
        let planeGeometry = SCNPlane(width: 50.0, height: 50.0)
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: 0)
        
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        cubeGeometry.materials = [redMaterial]
        
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor.green
        planeGeometry.materials = [greenMaterial]
        
        let constraint = SCNLookAtConstraint(target: cubeNode)
        constraint.isGimbalLockEnabled = true
        cameraNode.constraints = [constraint]
        lightNode.constraints = [constraint]
        
       
        
       

        
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(cubeNode)
        scene.rootNode.addChildNode(planeNode)
        scene.rootNode.addChildNode(cubeNodeTwo)
        
        animationMovement(cubeNode, values: (SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: -5, z: 0)), duration: 5.0)
animationMovement(cubeNodeTwo, values: (SCNVector3(x: 0, y: 0, z: 0), SCNVector3(x: 0, y: 5, z: 0)), duration: 5.0)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func animationMovement(_ node: SCNNode,values: (SCNVector3, SCNVector3), duration: Float) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.fromValue = values.0
        animation.toValue = values.1
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        node.addAnimation(animation, forKey: "position")
    }
    
    func animationHeight(_ node: SCNNode) {
        let animation = CABasicAnimation(keyPath: "geometry.height")
        animation.fromValue = 0.0
        animation.toValue = 10.0
        animation.duration = 10.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        node.addAnimation(animation, forKey: "height")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
   
        }
}

