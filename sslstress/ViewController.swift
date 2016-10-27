//
//  ViewController.swift
//  sslstress
//
//  Created by Tomas Hluchan on 25/10/2016.
//  Copyright © 2016 Tomas Hluchan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var config: URLSessionConfiguration?
    var session: URLSession?
    var gcounter: Int64 = 0
    
    
    @IBOutlet weak var actMon: UIActivityIndicatorView!
    @IBOutlet weak var resLabel: UILabel!
    @IBAction func btnAct(_ sender: AnyObject) {
        for _ in 1...100 {
            getUrl("https://www.seznam.cz/zpravy/clanek/tady-konci-legenda-pojdte-s-nami-do-nejznamejsiho-prazskeho-bytu-cena-50-milionu-3392")
            //getUrl("https://www.google.com")
            
        }
        actMon.startAnimating()
    }
    func getUrl(_ full_url: String) {
        let requestURL: URL = URL(string: full_url)!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL)
    
        let task = session!.dataTask(with: urlRequest as URLRequest
            
            ,completionHandler: {
                (data, response, error) -> Void in
                self.gcounter = self.gcounter + 1;
                print("############################ - ", self.gcounter)
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    print("expectedContentLength ", httpResponse.expectedContentLength)
                    print("data length ", data!.count)
                    if (Int64(data!.count) != httpResponse.expectedContentLength) {
                        print("XXDIFF")
                    }
                    
                    if (Int64(data!.count)<185000) {
                        print("XXTRUNC")
                        
                    }
                } else {
                    print("http get error", statusCode)
                }
        })
        task.resume()

    }
    
    func showUrlResult(_ res: String) {
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config = URLSessionConfiguration.default
        config?.httpShouldUsePipelining = true
        config?.tlsMinimumSupportedProtocol = SSLProtocol.tlsProtocol12
        config?.urlCache=nil
        session = URLSession(configuration: config!)
   
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

