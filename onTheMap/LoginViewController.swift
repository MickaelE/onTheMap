//
//  ViewController.swift
//  onTheMap
//
//  Created by Mickael Eriksson on 2015-08-04.
//  Copyright (c) 2015 Mickenet. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController, UIWebViewDelegate, FBSDKLoginButtonDelegate  {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height - 40);
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }
    
    @IBAction func signUpLink(sender: AnyObject) {
        //Todo!: 
       let url =  "https://www.udacity.com/account/auth#!/signup"
        let webV:UIWebView = UIWebView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height))
        webV.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
        webV.delegate = self;
        self.view.addSubview(webV)
    }

    @IBAction func faceBookLogin(sender: AnyObject) {
        //TODO! Fix facebook
    }
    
    @IBAction func touchUpLogin(sender: AnyObject) {
        
        UDYClient.sharedInstance().cred.email = emailText.text
        UDYClient.sharedInstance().cred.passWord = passwordText.text
        UDYClient.sharedInstance().authenticateWithViewController(self)
            { (success, errorString) in
            if success {
                self.completeLogin()
            } else {
                self.displayError(errorString)
            }
        }

    }
    
    func completeLogin() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("MapNavigationController") as! UITabBarController
            self.presentViewController(controller, animated: true, completion: nil)
        })
    }
    
    func displayError(errorString: String?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
               // self.debugTextLabel.text = errorString
            }
        })
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
         println("Webview fail with error \(error)");
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true;
    }
    func webViewDidStartLoad(webView: UIWebView) {
        println("Web did load")
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        println("Web did finish")
    }
   }

