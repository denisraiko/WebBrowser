//
//  ViewController.swift
//  WebBrowser
//
//  Created by Denis Raiko on 19.12.23.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        webView.navigationDelegate = self

        
        let homepage = "http://www.apple.com"
        
        let url = URL(string: homepage)
        let request = URLRequest(url: url!)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
        
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        
        
        textField.text = homepage
        
        
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    @IBAction func forwardButtonPressed(_ sender: UIButton) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    

}

extension ViewController: UITextFieldDelegate, WKNavigationDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let urlString = textField.text, !urlString.isEmpty else {
            return false
        }
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
        textField.resignFirstResponder()
        return true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        textField.text = webView.url?.absoluteString
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            if !textField.text!.lowercased().hasPrefix("http://") && !textField.text!.lowercased().hasPrefix("https://") {
                textField.text = "https://\(textField.text!)"
            }
        }
}
