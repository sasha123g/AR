//
//  ViewController.swift
//  project4
//
//  Created by Александр Арзамасцев on 05.08.2020.
//  Copyright © 2020 Александр Арзамасцев. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
 

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
  
    var  modelsDictionry: Dictionary<String,SCNNode?> = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        modelsDictionry = [
                "1": SCNScene(named:"art.scnassets/2.usdz")?.rootNode,
                "2": SCNScene(named:"art.scnassets/ship.scn")?.rootNode,
                "3": SCNScene(named:"art.scnassets/1.usdz")?.rootNode,
                "4": SCNScene(named:"art.scnassets/3.usdz")?.rootNode
        ]
       }
     
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // Create a session configuration
           let configuration = ARWorldTrackingConfiguration()

           guard let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "QR", bundle: Bundle.main) else {
               return
           }
           
           configuration.detectionImages = trackedImages
           configuration.maximumNumberOfTrackedImages = 1
        
           
       // Run the view's session
           sceneView.session.run(configuration)
       }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
 
        sceneView.session.pause()
        
    
    
    }
   
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?{
        let node = SCNNode()
        if let imageAnchor = anchor as? ARImageAnchor{
            
                    /*   let size = imageAnchor.referenceImage.physicalSize
                     let plane = SCNPlane(width: size.width, height: size.height)
                     plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.8)
                     plane.cornerRadius = 0.005
                     let planeNode = SCNNode(geometry: plane)
                    planeNode.eulerAngles.x = -.pi / 2
                 node.addChildNode(planeNode)*/
           
            var shapeNode:SCNNode?
            
            for model in modelsDictionry {
                if model.key == imageAnchor.referenceImage.name {
                    shapeNode = model.value
                }
            }
          guard let shape = shapeNode else {return nil}
            node.addChildNode(shape)
            shapeNode?.runAction(SCNAction.repeat(SCNAction.rotateBy(x: 0, y: 1, z: 0, duration: 2), count: 200))
            
            
        
    }
        
return node
}
    
    

}
