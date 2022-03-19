//
//  TableViewController.swift
//  TodoList
//
//  Created by Wongil on 2022/03/14.
//

import UIKit

var todoLists = ["끝장나게 밥 먹기", "끝장나게 물 마시기", "끝장나게 씻기", "죽여주게 잠자기"]
var completeList: [Bool] = []

class TableViewController: UITableViewController {
    @IBOutlet var tblTodo: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in todoLists {
            completeList.append(false)
        }
        
        // 오늘 날짜 yyyy-MM-dd 형식으로 변환 후 타이틀 세팅
        let nowDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let convertDate = dateFormatter.string(from: nowDate)
        
        self.title = convertDate

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // 왼쪽 상단에 Edit 버튼 추가
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    func fetch() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
    }

    // MARK: - Table view data source
    
    // 테이블 뷰가 화면에 보일 때 테이블 뷰 데이터 reload
    override func viewWillAppear(_ animated: Bool) {
        tblTodo.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        if completeList[indexPath.row] {
            let attributeText = NSMutableAttributedString(string: todoLists[indexPath.row])

            attributeText.addAttribute(.strikethroughStyle,
                                            value: NSUnderlineStyle.single.rawValue,
                                            range: NSMakeRange(0, attributeText.length))
            
            cell.textLabel?.attributedText = attributeText
        } else {
            cell.textLabel?.text = todoLists[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // table cell을 왼쪽으로 밀었을 때 셀 삭제 버튼 이벤트
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todoLists.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // table cell 이동 함수
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let todoToItem = todoLists[fromIndexPath.row]
        todoLists.remove(at: fromIndexPath.row)
        todoLists.insert(todoToItem, at: to.row)
    }

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
