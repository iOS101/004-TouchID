//
//  ViewController.swift
//  004-TouchID
//
//  Created by liluo on 9/18/14.
//  Copyright (c) 2014 liluo. All rights reserved.
//

import UIKit
import LocalAuthentication


class ViewController: UIViewController {
                            
  @IBOutlet var statusLabel: UILabel
  

  
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func testButton(sender: AnyObject) {

    var touchIDContext = LAContext()
    var touchIDError : NSError?

    statusLabel.hidden = false

    if touchIDContext.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIDError) {
      statusLabel.text = "正在验证 Touch ID..."
      touchIDContext.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason: "这是一个 Touch ID 的测试", reply: {
        (success: Bool, error: NSError?) -> Void in
        if success {
          self.statusLabel.text = "通过验证 :)"
        } else {
          var errorMsg = "未通过验证 :("
          switch error!.code {
          case LAError.UserCancel.toRaw():
            errorMsg = "用户取消验证"
          case LAError.PasscodeNotSet.toRaw():
            errorMsg = "爪机没有设置密码"
          case LAError.SystemCancel.toRaw():
            errorMsg = "系统中止验证"
          case LAError.UserFallback.toRaw():
            errorMsg = "手动输入密码去鸟"
          case LAError.AuthenticationFailed.toRaw():
            errorMsg = "未通过验证"
          default:
            errorMsg = "未知错误"
          }
          self.statusLabel.text = errorMsg
        }
        })
      
    } else {
      statusLabel.text = "呃, 你的爪机似乎不支持 Touch ID..."
    }
  }

}

