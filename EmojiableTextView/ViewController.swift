//
//  ViewController.swift
//  EmojiableTextView
//
//  Created by zackzheng on 2022/3/9.
//

import UIKit

class ViewController: UIViewController {
    
    private let textView = EmojiableTextView(frame: .zero, textContainer: nil)
    private let emotionButton: UIButton = UIButton()
    private let endEditingButton: UIButton = UIButton()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        setupTextView()
        setupActionButton()
        setupEndEditingButton()
    }
}

extension ViewController {
    
    private func setupTextView() {

        textView.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 15
        textView.delegate = self
        textView.emojiableTextViewDelegate = self
        view.addSubview(textView)
        textView.frame = CGRect(x: 20, y: 100, width: 200, height: 32)
    }
    
    private func setupActionButton() {
        
        emotionButton.setImage(UIImage(named: "icon_input_text"), for: .selected)
        emotionButton.setImage(UIImage(named: "icon_input_emoji"), for: .normal)
        emotionButton.isSelected = true
        emotionButton.addTarget(self, action: #selector(onClickActionButton(sender:)), for: .touchUpInside)
        view.addSubview(emotionButton)
        emotionButton.frame = CGRect(x: 230, y: 100, width: 32, height: 32)
    }
    
    private func setupEndEditingButton() {

        endEditingButton.layer.borderColor = UIColor.black.withAlphaComponent(0.6).cgColor
        endEditingButton.layer.borderWidth = 1
        endEditingButton.layer.cornerRadius = 16
        endEditingButton.setTitleColor(.darkGray, for: .normal)
        endEditingButton.setTitle("End Editing", for: .normal)
        endEditingButton.addTarget(self, action: #selector(onClickEndEditingButton(sender:)), for: .touchUpInside)
        view.addSubview(endEditingButton)
        endEditingButton.frame = CGRect(x: 270, y: 100, width: 100, height: 32)
    }
    
    @objc func onClickActionButton(sender: UIButton) {

        if self.textView.isFirstResponder {
            sender.isSelected = !sender.isSelected
            self.textView.enableEmojiMode = sender.isSelected
        } else {
            self.textView.enableEmojiMode = false
            self.textView.becomeFirstResponder()
        }
    }
    
    @objc func onClickEndEditingButton(sender: UIButton) {

        view.endEditing(true)
    }
}

extension ViewController: EmojiableTextViewDelegate {

    func emojiableTextView(_ textView: EmojiableTextView, didChangeMode emojiEnabled: Bool) {
        emotionButton.isSelected = emojiEnabled
    }
}

extension ViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        emotionButton.isSelected = self.textView.enableEmojiMode
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        emotionButton.isSelected = true
    }
}
