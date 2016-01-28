//
//  SecondViewController.swift
//  Task App
//
//  Created by Daniel Oram on 28/01/16.
//  Copyright © 2016 Danoram. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    
    var dateFormatter = NSDateFormatter()
    
    
    @IBOutlet var txtTaskName: UITextField!
    @IBOutlet var txtTaskDesc: UITextField!
    @IBOutlet var labelTaskDate: UILabel!
    
    @IBOutlet var dateView: UIView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func btnOpenDateView(sender: UIButton){
        print("open dateview")
        dateView.hidden = false
    }
    
    @IBAction func btnAddDate(sender: UIButton){
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        labelTaskDate.text = strDate
        print("beep")
        dateView.hidden = true
    }
    
    @IBAction func btnCancelDate(sender: UIButton){
        dateView.hidden = true
    }
    
    @IBAction func btnAddTask(sender : UIButton){
        if (txtTaskName.text == ""){
            //Task Title is blank, do not add a record
        } else {
            
            
            //add record
            taskMgr.addTask(txtTaskName.text!, desc: txtTaskDesc.text!, date: labelTaskDate.text!)
            print("task added")
            
            //save tasks
            taskMgr.saveTasks()
            print("task saved to memory")
            
            //dismiss keyboard and reset fields
            
            self.view.endEditing(true)
            txtTaskName.text = nil
            txtTaskDesc.text = nil
            
        }
        
    }
    
        
    //MARK: delegate functions

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
    }
    
    override func viewWillAppear(animated: Bool) {
        //let dateFormatter = NSDateFormatter()
        //let strDate = dateFormatter.stringFromDate(NSDate())
        //labelTaskDate.text = strDate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //dismiss keyboard when user touches screen
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    


}

