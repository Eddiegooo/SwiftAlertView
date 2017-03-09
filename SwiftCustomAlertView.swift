//
//  SwiftCustomAlertView.swift
//  testSwift
//
//  Created by FQL on 2017/3/9.
//  Copyright © 2017年 EddieFan. All rights reserved.
//

import UIKit

class SwiftCustomAlertView: UIView {

//    typealias clickAlertClosure = (_ index: Int) -> Void //声明闭包，点击按钮传值
//    //把申明的闭包设置成属性
//    var clickClosure: clickAlertClosure?
//    //为闭包设置调用函数
//    func clickIndexClosure(_ closure:clickAlertClosure?){
//        //将函数指针赋值给myClosure闭包
//        clickClosure = closure
//    }
    
    typealias blocks  = () -> Void //声明闭包，点击按钮传值
    
    var cancelBlock: blocks?
    var sureBlock: blocks?
    
    
    let Screen_width = UIScreen.main.bounds.size.width
    let Screen_height = UIScreen.main.bounds.size.height
    let bgView = UIView()
    let titleLabel = UILabel() //标题按钮
    let contentLabel = UILabel() //显示内容
    var title = "" //标题
    var content = "" //内容
    let cancelBtn = UIButton() //取消按钮
    let sureBtn = UIButton() //确定按钮
    let Bgtap = UITapGestureRecognizer() //点击手势
    
    
    public class func initAlertView(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?, cancelFuncs: @escaping (() -> Void), sureFuncs: @escaping (() -> Void)) -> SwiftCustomAlertView {
        let alerView = SwiftCustomAlertView.init(title: title, message: message, cancelButtonTitle: cancelButtonTitle, sureButtonTitle: sureButtonTitle, cancelFuncs: cancelFuncs, sureFuncs: sureFuncs)
        alerView.show()
        return alerView
    }
    
    
    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?, cancelFuncs: @escaping (() -> Void), sureFuncs: @escaping (() -> Void)){
        super.init(frame: CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height))
        createAlertView()
        self.titleLabel.text = title
        self.contentLabel.text = message
        self.cancelBtn.setTitle(cancelButtonTitle, for: UIControlState())
        self.sureBtn.setTitle(sureButtonTitle, for: UIControlState())
        cancelBlock = cancelFuncs
        sureBlock   = sureFuncs
    }
    
    //MARK:创建
    func createAlertView() {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height)
//        self.backgroundColor = UIColor.clear
        self.addGestureRecognizer(Bgtap)

        //白底
        bgView.frame = CGRect(x: 30, y: Screen_height/2 - 100, width: Screen_width - 60, height: 200)
        bgView.backgroundColor = UIColor.white
        self.addSubview(bgView)
        
        let width = bgView.frame.size.width
        //标题
        titleLabel.frame = CGRect(x: 0, y: 15, width: width, height: 25)
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        titleLabel.textAlignment = .center
        bgView.addSubview(titleLabel)
        //内容
        contentLabel.frame = CGRect(x: 24, y: 56, width: width - 48, height: 68)
        contentLabel.numberOfLines = 0
        contentLabel.textColor = UIColor.black
        contentLabel.font = UIFont.systemFont(ofSize: 17)
        bgView.addSubview(contentLabel)
        //取消按钮
        let btnWith = (width - 30) / 2
        cancelBtn.frame = CGRect(x: 10, y: 145, width: btnWith, height: 45)
        cancelBtn.backgroundColor = UIColor.gray
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        cancelBtn.tag = 1
        cancelBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(cancelBtn)
        //确认按钮
        sureBtn.frame = CGRect(x: btnWith + 20 , y: 145, width: btnWith, height: 45)
        sureBtn.backgroundColor = UIColor.red
        sureBtn.setTitleColor(UIColor.white, for: UIControlState())
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        sureBtn.layer.cornerRadius = 3
        sureBtn.clipsToBounds = true
        sureBtn.tag = 2
        sureBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(sureBtn)
    }
    
    //MARK:按键的对应的方法
    func clickBtnAction(_ sender: UIButton) {
        let index = sender.tag
        if index == 1 {
            if cancelBlock != nil {
                cancelBlock!()
            }
        }else {
            sureBlock!()
        }
        dismiss()
    }
    //MARK:消失
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.bgView.alpha = 0
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
