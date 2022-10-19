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
        //        let toolBarRect = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35) 上記の一文と同じ処理
        //        let toolBar = UIToolbar(frame: toolBarRect)
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

//    //ユニットテスト用
//    func saveRecord(with name: String, with text: String) -> Bool {
//        let tweetTextCount = inputTweetText.text.count
//        if tweetTextCount > maxTweetLength {
//           return true
//        } else {
//            return false
//        }
            
        print("ユーザー名:\(record.name),ツイート文:\(record.text),日付: \(record.recordDate)")
        dismiss(animated: true)
    }
    }
    
    //ホーム画面へ戻る
    func transitionToHomeView() {
        dismiss(animated: true, completion: nil)
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)  //Storyboardをインスタンス化し、コード上でストーリーボードを使えるようにする
        //        guard let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return } //instantiateViewControllerメソッドを使ってTweetViewControllerもインスタンス化
        //        present(homeViewController, animated: true) //presentメソッドで画面遷移
    }
    
    func tweerCancel() {
        dismiss(animated: true, completion: nil)
    }
        
//    internal func textViewDidChangeSelection(_ textView: UITextView) {
//            guard let tweetTetxCount = inputTweetText.text else { return }
//
//                if tweetTetxCount.count > maxTweetLength {
//
//                    // 最大文字数超えた場合は切り捨て
//                    inputTweetText.text = String(tweetTetxCount.prefix(maxTweetLength))
//
//                    //inputTweetText.textの文字数がmaxTweetLengthを超える場合は、
//                    //それ以降の文字を切り捨てたものをinputTweetText.textに代入しています。
//        }
//    }
}


