//
//  AvatarViewer.swift
//  Travel Diaries
//
//  Created by Kailash on 28/04/24.
//

import SwiftUI
import SceneKit
import SceneKit.ModelIO

struct AvatarViewer: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Home()
        }
        .preferredColorScheme(.dark)
    }
}

struct Home: View {
    
    @State var scene: SCNScene? = .init(named: "avatar3.usdz")
    
    var body: some View {
        CustomSceneView(scene: $scene)
            .frame(height: 800)
            
    }
}

struct CustomSceneView: UIViewRepresentable {
    
    @Binding var scene: SCNScene?
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        view.allowsCameraControl = true
        view.autoenablesDefaultLighting = true
        view.antialiasingMode = .multisampling4X
        view.backgroundColor = .clear
        view.scene = scene
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
}


#Preview {
    AvatarViewer()
}
