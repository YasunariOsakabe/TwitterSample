//
//  TweetViewController.swift
//  TwitterSample
//
//  Created by 小坂部泰成 on 2022/10/18.
//

import UIKit
import RealmSwift

class TweetViewController: UIViewController,UITextViewDelegate {
    @IBOutlet weak var inputUserName: UITextField!
    @IBOutlet weak var inputTweetText: UITextView!
    @IBOutlet weak var tweetAddButton: UIButton!
    //ツイートボタンをタップ時の処理（データ保存、HomeViewControllerのCellにテキスト反映
    @IBAction func tweetAddButton(_ sender: UIButton){
        saveRecord(with: inputUserName.text ?? "", with: inputTweetText.text)
    }
    //キャンセルボタンタップ時の処理（ホーム画面に戻る）
    @IBAction func tappedCancel(_ sender: Any) {
        transitionToHomeView()
    }
    
    
    //TweetDetaModelをインスタンス化しアクセスできるように
    var record: TweetDetaModel = TweetDetaModel()
    
    //文字数制限
    let maxTweetLength = 140
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDoneButton()
        configureTweetAddButton()
        navigationItem.title = "新規投稿"
        inputTweetText.delegate = self
    }
    
    
    var toolBar: UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
        toolBar.items = [commitButton] //toolBarには複数のコンポーネントが格納できるため配列形式で記述する
        return toolBar
    }
    //キーボード閉じるボタンを追加
    func setDoneButton() {
        inputUserName.inputAccessoryView = toolBar
        inputTweetText.inputAccessoryView = toolBar
    }
    //キーボードを閉じる処理
    @objc func tapDoneButton() {
        view.endEditing(true)
    }
    //tweetAddButtonを角丸にする
    func configureTweetAddButton() {
        tweetAddButton.layer.cornerRadius = 5
    }
    
    //    データ保存メソッド（内容を上書きしつつ、データ保存) ,文字数制限も追加（ツイート文が140字以上の場合はデータ保存されないように）
    func saveRecord(with name: String, with text: String) {
        let realm = try! Realm()
        let tweetTextCount = inputTweetText.text.count
        if tweetTextCount > maxTweetLength {
            print("文字制限数を超えたためツイートすることができません")
            tweerCancel()
        } else {
            try!realm.write {
                record.text = text
                record.name = name
                record.recordDate = Date()
                realm.add(record)
            }
            
            print("ユーザー名:\(record.name),ツイート文:\(record.text),日付: \(record.recordDate)")
            dismiss(animated: true)
        }
    }
    
    //ホーム画面へ戻る
    func transitionToHomeView() {
        dismiss(animated: true, completion: nil)
    }
    
    func tweerCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}


