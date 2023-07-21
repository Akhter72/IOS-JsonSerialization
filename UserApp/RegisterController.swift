//
//  RegisterController.swift
//  UserApp
//
//  Created by Mac on 18/07/23.
//

import UIKit
import CoreData

class RegisterController: UIViewController {
    @IBOutlet weak var nameInp: UITextField!
    @IBOutlet weak var emailInp: UITextField!
    @IBOutlet weak var phoneInp: UITextField!
    @IBOutlet weak var passwordInp: UITextField!
    @IBOutlet weak var RegisterBtn: UIButton!
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        RegisterBtn.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedObjectContext = appDelegate.persistentContainer.viewContext
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func registerAction() {
        let user = fetchData()
        if user == nil {
            saveData()
        } else {
            let alert = UIAlertController(title: "login", message: "user already exists with name \(user?.name! ?? "")", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .cancel)
            alert.addAction(okAction)
            if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                    viewController.present(alert, animated: true, completion: nil)
                }
        }
    }
    
    func saveData() {
        let entity = NSEntityDescription.entity(forEntityName: "MyUser", in: managedObjectContext!)!
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first ?? "Not Found")
        let newUser = NSManagedObject(entity: entity, insertInto: managedObjectContext!)
        newUser.setValue(nameInp.text, forKey: "name")
        newUser.setValue(emailInp.text, forKey: "email")
        newUser.setValue(phoneInp.text, forKey: "phone")
        newUser.setValue(passwordInp.text, forKey: "password")
        do {
            try managedObjectContext!.save()
            print("save Successfull")
        } catch {
            print("save unsucessfull")
        }
    }
    
    func fetchData() -> MyUser? {
        let fetchRequest: NSFetchRequest<MyUser> = MyUser.fetchRequest()
        let predicate = NSPredicate(format: "email == %@", emailInp.text!.lowercased())
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedObjectContext!.fetch(fetchRequest)
            return results.first
        } catch {
            print("error in fetching data")
        }
        return nil
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
