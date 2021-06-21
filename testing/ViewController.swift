//
//  ViewController.swift
//  testing
//
//  Created by manish on 09/06/21.
//

import UIKit

/// this class used for the main view controller.
class ViewController: UIViewController {
    
    
    // MARK: IBOutlets
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textProfession: UITextField!
    var arrdata = [Person]()
    var arr = [3,4,2,1,4,4]
    
    @IBOutlet weak var tbldata: UITableView!
    // MARK: LifeCycle of ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loadinglete view.
        arrdata = DatabaseHelper.sharedInstance.getData()

       
    }
    @objc func sort() {
    
        for i in 1..<arr.count{
            for j in 0..<arr.count - i{
                if(arr[j] > arr[j + 1])
                {
                    arr.swapAt(j, j + 1)
                }
            }
        }
        print(arr)
    }
    // MARK: IBActions
    @IBAction func btnSave(_ sender: Any) {
        
        let dict = ["name":textName.text,"profession":textProfession.text]
        DatabaseHelper.sharedInstance.saveData(object: dict as! [String:String])
        self.tbldata.reloadData()
        
        
    }
    
}
extension ViewController: UITableViewDataSource,UITableViewDelegate {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrdata.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =  tbldata.dequeueReusableCell(withIdentifier: "viewcontrollercellTableViewCell", for: indexPath) as! viewcontrollercellTableViewCell
   
    cell.lblName.text = arrdata[indexPath.row].name
    cell.lblprofession.text = arrdata[indexPath.row].profession
    return cell
   }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           arrdata = DatabaseHelper.sharedInstance.deletedata(index: indexPath.row)
            self.tbldata.deleteRows(at: [indexPath], with: .automatic)
        
        }
        else if editingStyle == .insert {
            print("mni")
        }
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let more = UITableViewRowAction(style: .normal, title: "More") { action, index in
            print("more button tapped")
        }
        more.backgroundColor = .lightGray

        let favorite = UITableViewRowAction(style: .normal, title: "Favorite") { action, index in
            print("favorite button tapped")
        }
        favorite.backgroundColor = .orange

        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            print("share button tapped")
        }
        share.backgroundColor = .blue

        return [share, favorite, more]
}
}


