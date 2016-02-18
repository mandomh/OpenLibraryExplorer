//
//  BookViewController.swift
//  OpenLibraryExplorer
//
//  Created by Mando on 2/17/16.
//  Copyright © 2016 Armando Muñoz Hernández. All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

	var isbn: String? = nil
	@IBOutlet weak var isbnLabel: UILabel!
	@IBOutlet weak var bookTextView: UITextView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.activityIndicator.startAnimating()
		self.isbnLabel.text = self.isbn!
		self.bookTextView.text = ""
		self.loadBook(isbn!)
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	private func loadBook(let isbn: String) {
		let urlString = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
		let url: NSURL? = NSURL(string: urlString)
		let request: NSURLRequest = NSURLRequest(URL: url!)
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: config)
		let task = session.dataTaskWithRequest(request, completionHandler: self.loadBookCompletionHandler)
		task.resume()
	}
	
	private func loadBookCompletionHandler(data: NSData?, response: NSURLResponse?, error: NSError?) {
		dispatch_async(dispatch_get_main_queue(), {
			if error == nil {
				let text = String(data: data!, encoding: NSUTF8StringEncoding)
				self.bookTextView.text = text
			} else {
				let alertController = UIAlertController(title: self.isbn, message: "Ocurrió un error al tratar de acceder el libro solicitado (\(error!.code)). Verifica tu conexión a Internet", preferredStyle: UIAlertControllerStyle.Alert)
				alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default, handler: nil))
				self.presentViewController(alertController, animated: true, completion: nil)
			}
			self.activityIndicator.stopAnimating()
		})
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
