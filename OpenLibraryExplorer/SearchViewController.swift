//
//  ViewController.swift
//  OpenLibraryExplorer
//
//  Created by Mando on 2/17/16.
//  Copyright © 2016 Armando Muñoz Hernández. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var isbnTextField: UITextField!
	@IBOutlet weak var searchBarButton: UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.isbnTextField.delegate = self
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func textFieldShouldReturn(textField: UITextField) -> Bool {
		self.isbnTextField.resignFirstResponder()
		performSegueWithIdentifier("bookSegue", sender: nil)
		return true
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier! == "bookSegue" {
			let bookViewController = segue.destinationViewController as! BookViewController
			bookViewController.isbn = isbnTextField.text			
		}
	}
}

