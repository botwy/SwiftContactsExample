//
//  ContactsViewController.swift
//  ContactsExample
//
//  Created by Admin on 29.05.2019.
//  Copyright © 2019 goncharov denis. All rights reserved.
//

import UIKit
import MessageUI

class ContactsViewController: UIViewController, UITableViewDelegate {
  @IBOutlet weak var backgroundView: UIView!
  @IBOutlet weak var tableView: UITableView!
  
  @IBOutlet weak var closeButton: UIButton!
  @IBAction func onClosePress(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      backgroundView.layer.cornerRadius = 40
      let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panHandler(gestureRecognizer:)))
      let panelGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panHandler(gestureRecognizer:)))
      //gestureRecognizer.cancelsTouchesInView = false
      tableView.addGestureRecognizer(gestureRecognizer)
      backgroundView.addGestureRecognizer(panelGestureRecognizer)
      gestureRecognizer.delegate = self
    }
    

  @objc func panHandler(gestureRecognizer: UIPanGestureRecognizer) {
    let changeY = gestureRecognizer.translation(in: view).y
    switch gestureRecognizer.state {
    case .changed:
      if changeY > 50 {
        dismiss(animated: true, completion: nil)
      }
    default:
      ()
    }
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard MFMailComposeViewController.canSendMail() else { return }
    let application = UIApplication.shared
    let composeVC = MFMailComposeViewController()
    composeVC.setToRecipients(["botwy@mail.ru"])
    application.keyWindow?.rootViewController?.present(composeVC, animated: true, completion: nil)
    //self.present(composeVC, animated: true, completion: nil)
//    guard let url = URL(string: "mailto:botwy@mail.ru"), application.canOpenURL(url) else {
//      return
//
//    }
//    print("did select")
//    application.open(url, options: [:], completionHandler: nil)
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    print("view controller touches end")
    dismiss(animated: true, completion: nil)
  }
}

extension ContactsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "Cell") as! UITableViewCell
  }
  
  
}

extension ContactsViewController: UIGestureRecognizerDelegate {
  func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if tableView.bounds.origin.y <= 0 {
      return true
    }
    
    return false
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
