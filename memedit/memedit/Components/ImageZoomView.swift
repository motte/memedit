//
//  ImageZoomView.swift
//  memedit
//
//  Created by Michael Otte on 11/20/22.
//

import SwiftUI
import PDFKit

struct ImageZoomView: UIViewRepresentable {
    let image: UIImage
    
    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()
        
        guard let page = PDFPage(image: image) else { return view }
        view.document?.insert(page, at: 0)
        view.autoScales = true
        view.backgroundColor = .clear
        
        return view
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) { }
}
