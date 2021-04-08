//
//  LoadingView.swift
//  FreshMasters
//
//  Created by John Crawford on 4/7/21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable{
    
    @Binding var shouldAnimate: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor(.brandPrimary)
        return activityIndicatorView
    }

    func updateUIView(_ uiView: UIActivityIndicatorView,
                      context: Context) {
        if self.shouldAnimate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }

}
