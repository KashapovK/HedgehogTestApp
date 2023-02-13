//
//  WebViewController.swift
//  HedgehogTestApp
//
//  Created by Konstantin Kashapov on 11.02.2023.
//

import UIKit
import WebKit

final class WebViewController: UIViewController, WKUIDelegate {
    // MARK: - Views
    private var webView: WKWebView!
    
    // MARK: - Properties
    private let urlString: String
    
    // MARK: - Initialize
    init(urlString: String) {
        self.urlString = urlString
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycle
    override func loadView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
    }
    
    // MARK: - Private methods
    private func setupWebView() {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        ///xcode complains about threads when using webView. I would use sfSafari to prevent this from happening (there was a topic from Apple that this is their cant). But the technical specification specifies the webView
        DispatchQueue.main.async {
            self.webView.load(request)
        }
    }
}
