//
//  AddViewController.swift
//  TodoList
//
//  Created by Wongil on 2022/03/15.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var txtTodoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Add Button 클릭 시 todoLists에 작성한 todo 넣어주고 전 화면으로 전환
    @IBAction func btnAddTodo(_ sender: UIButton) {
        todoLists.append(txtTodoField.text!)
        completeList.append(false)
        _ = navigationController?.popViewController(animated: true)
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
