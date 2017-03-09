# SwiftAlertView
用swift写的 一个自定义的UIAlertView
继承自UIView ，一句话调用。
####使用方法：直接将SwiftCustomAlertView 文件拖到工程中就可以了

####功能：包含了确认、取消处理的方式

###引用示例：
`     SwiftCustomAlertView.initAlertView(title: "title", message: "this is Message", cancelButtonTitle: "cancel", sureButtonTitle: "sure", cancelFuncs: { 
        print("取消的按键处理事情")
      }) { 
        print("确认按键的处理事情")
        }
    }
`
