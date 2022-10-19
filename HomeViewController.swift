import Foundation
import UIKit
import RealmSwift

//TableViewCellを使用する際はUITableViewDelegate,UITableViewDataSourceを継承する
class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func tappedButton(_ sender: UIButton) {
        transitionToTweetView() //+ボタンタップ時に画面遷移
    }
    
    var tweetDeta: [TweetDetaModel] = []
    
    //日付表示スタイルを定義
    var dateFormat: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy年MM月dd日", options: 0, locale: Locale(identifier:  "ja_JP"))
        dateFormatter.dateStyle = .long
        //        dateFormatter.timeStyle = .short
        return dateFormatter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() //tableViewの下部にフッタービューを設定
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        //↑このコードでHomeTableViewCellを登録してるイメージ
        
        self.tableView.estimatedRowHeight = 1000  //セルの高さを可変r
        self.tableView.rowHeight = UITableView.automaticDimension
        
        //ナビゲーションバーにツイッターアイコンを表示
        let imageView = UIImageView(image: UIImage(named: "twitterIcon"))
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        
        configureButton()  //ボタンを角丸にする
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTweetDate() //HomeViewController表示時にデータ取得
        tableView.reloadData() //表示更新
    }
    
    
    //セルの数を指定するブロック
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDeta.count
    }
    //どんなセルを表示するか（中身を定義）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! HomeTableViewCell  //.xibカスタムセル使用時
        let tweetDetaModel :TweetDetaModel = tweetDeta[tweetDeta.count - indexPath.row - 1]
        cell.userName.text = tweetDetaModel.name
        cell.label.text = tweetDetaModel.text
        cell.date.text = "\(dateFormat.string(from: tweetDetaModel.recordDate))"  //日付表示スタイルを変更
        return cell
    }
    //+ボタンを円形にする
    func configureButton() {
        addButton.layer.cornerRadius = addButton.bounds.width / 2
    }
    
    //TweetViewControllerへ画面遷移するためのメソッド
    func transitionToTweetView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)  //Storyboardをインスタンス化し、コード上でストーリーボードを使えるようにする
        guard let tweetViewController = storyboard.instantiateViewController(withIdentifier: "TweetViewController") as? TweetViewController else { return } //instantiateViewControllerメソッドを使ってTweetViewControllerもインスタンス化
        tweetViewController.modalPresentationStyle = .fullScreen
        present(tweetViewController, animated: true) //presentメソッドで画面遷移
    }
    
    //realm保存データを取得
    func setTweetDate() {
        let realm = try! Realm()
        let result = realm.objects(TweetDetaModel.self)
        tweetDeta = Array(result)
        print("データ取得しました")
    }
    
    
}


