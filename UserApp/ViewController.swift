//
//  ViewController.swift
//  UserApp
//
//  Created by Mac on 17/07/23.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var managedObjectContext: NSManagedObjectContext?
    @IBOutlet weak var usernameLbl: UITextField!
    
    @IBOutlet weak var passwordLbl: UITextField!
    
    @IBAction func toRegisterPageBtn(_ sender: UIButton) {
        print("pressed")
        let storyboard = self.storyboard?.instantiateViewController(identifier: "RegisterController") as! RegisterController
        navigationController?.pushViewController(storyboard, animated: true)
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        let user = fetchData()
        let alert = UIAlertController(title: "login", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .cancel)
        alert.addAction(okAction)
        if user != nil {
            if user?.password == passwordLbl.text {
                alert.message = "Successfull login"
            } else {
                alert.message = "invalid password"
            }
        } else {
            alert.message = "user not found"
        }
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                viewController.present(alert, animated: true, completion: nil)
            }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "Not Found")
        print("hello")
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedObjectContext = appDelegate.persistentContainer.viewContext
        }
    }
    

    
    func fetchData() -> UserModel? {
        let fetchRequest: NSFetchRequest<MyUser> = MyUser.fetchRequest()
        
        do {
            let results = try managedObjectContext!.fetch(fetchRequest)
            for user in results {
                print(user.name)
                if user.name?.lowercased() == usernameLbl.text?.lowercased() {
                    let newUser = UserModel()
                    newUser.name = user.name
                    newUser.email = user.email
                    newUser.phone = user.phone
                    newUser.password = user.password
                    return newUser
//                    break
                }
            }
        } catch {
            print("error in fetching data")
        }
        return nil
    }

}

