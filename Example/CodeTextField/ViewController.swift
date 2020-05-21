//
//  ViewController.swift
//  CodeTextField
//
//  Created by LiuSky on 05/21/2020.
//  Copyright (c) 2020 LiuSky. All rights reserved.
//

import UIKit
import CodeTextField

/// MARK - 演示
final class ViewController: UIViewController {

    /// 样式1
    private lazy var style1: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 4,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "0123456789"),
                                         characterLabelGenerator: { (_) -> LableRenderable in
                                           return StyleLabel(size: CGSize(width: 50, height: 50))
        })
        temTextField.keyboardType = .numberPad
        temTextField.translatesAutoresizingMaskIntoConstraints = false
        return temTextField
    }()
    
    
    /// 样式2
    private lazy var style2: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 4,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "0123456789"),
                                         characterLabelGenerator: { (idx) -> LableRenderable in
                                            switch idx {
                                            case 0:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            case 1:
                                                return StyleLabel(size: CGSize(width: 60, height: 50))
                                            case 2:
                                                return CustomLabel(size: CGSize(width: 70, height: 50))
                                            default:
                                                return StyleLabel(size: CGSize(width: 80, height: 50))
                                            }
        })
        temTextField.keyboardType = .numberPad
        temTextField.translatesAutoresizingMaskIntoConstraints = false
        return temTextField
    }()
    
    /// 样式3
    private lazy var style3: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 6,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "0123456789"),
                                         characterLabelGenerator: { (_) -> LableRenderable in
                                            let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                            label.style = Style.border(nomal: UIColor.gray, selected: UIColor.red)
                                            return label
        })
        temTextField.keyboardType = .numberPad
        temTextField.translatesAutoresizingMaskIntoConstraints = false
        return temTextField
    }()
    
    
    /// 样式4
    private lazy var style4: CodeTextField = {
        
        let temTextField = CodeTextField(codeLength: 6,
                                         characterSpacing: 10,
                                         validCharacterSet: CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"),
                                         characterLabelGenerator: { (idx) -> LableRenderable in
                                            
                                            switch idx {
                                            case 0:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            case 1:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.blue)
                                                return label
                                            case 2:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            case 3:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.orange)
                                                return label
                                            case 4:
                                                return StyleLabel(size: CGSize(width: 50, height: 50))
                                            default:
                                                let label = StyleLabel(size: CGSize(width: 50, height: 50))
                                                label.style = Style.border(nomal: UIColor.gray, selected: UIColor.purple)
                                                return label
                                            }
        })
        temTextField.keyboardType = .asciiCapable
        temTextField.autocorrectionType = .no
        temTextField.translatesAutoresizingMaskIntoConstraints = false
        return temTextField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(style1)
        view.addSubview(style2)
        view.addSubview(style3)
        view.addSubview(style4)
        
        NSLayoutConstraint.activate([
            style1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            style1.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            style1.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        NSLayoutConstraint.activate([
            style2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            style2.topAnchor.constraint(equalTo: style1.bottomAnchor, constant: 20),
            style2.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            style3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            style3.topAnchor.constraint(equalTo: style2.bottomAnchor, constant: 20),
            style3.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            style4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            style4.topAnchor.constraint(equalTo: style3.bottomAnchor, constant: 20),
            style4.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

