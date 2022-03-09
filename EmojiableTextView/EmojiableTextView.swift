//
//  EmojiableTextView.swift
//  EmojiableTextView
//
//  Created by zackzheng on 2022/3/9.
//

import UIKit

protocol EmojiableTextViewDelegate: AnyObject {

    func emojiableTextView(_ textView: EmojiableTextView, didChangeMode emojiEnabled: Bool)
}

class EmojiableTextView: UITextView {

    weak var emojiableTextViewDelegate: EmojiableTextViewDelegate?

    var enableEmojiMode: Bool = false {
        didSet {
            if isFirstResponder {
                resignFirstResponder()
                becomeFirstResponder()
            }
        }
    }
    
    private let emojiPrimaryLanguage: String = "emoji"

    override var textInputContextIdentifier: String? {
        return enableEmojiMode ? emojiPrimaryLanguage : nil
    }

    override var textInputMode: UITextInputMode? {
        return enableEmojiMode ? UITextInputMode.activeInputModes.first(where: { $0.primaryLanguage == emojiPrimaryLanguage }) : nil
     }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        NotificationCenter.default.addObserver(self, selector: #selector(inputModeDidChange), name: UITextInputMode.currentInputModeDidChangeNotification, object: nil)
     }

     @objc func inputModeDidChange(_ notification: Notification) {
         
         if let mode = notification.userInfo?["UITextInputFromInputModeKey"] as? UITextInputMode, let primaryLanguage = mode.primaryLanguage {

             if primaryLanguage == emojiPrimaryLanguage {
                 emojiableTextViewDelegate?.emojiableTextView(self, didChangeMode: false)
             } else {
                 emojiableTextViewDelegate?.emojiableTextView(self, didChangeMode: true)
             }
         }
     }
}
