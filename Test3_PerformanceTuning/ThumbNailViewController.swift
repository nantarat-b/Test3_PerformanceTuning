//
//  ThumbNailViewController.swift
//  Test3_PerformanceTuning
//
//  Created by Lunar's Macbook Pro on 2/5/2561 BE.
//  Copyright © 2561 Lunar's Macbook Pro. All rights reserved.
//

import UIKit

class ThumbNailViewController: UITableViewController {

    @IBOutlet var thumbNailTableView: UITableView!
    var datasourceList: [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        thumbNailTableView.delegate = self
        thumbNailTableView.dataSource = self
        
        self.base64Image(imageString: TestData.datasourceList[0], completion: { (image) in
            self.datasourceList.append(image)
            self.base64Image(imageString: TestData.datasourceList[1], completion: { (image) in
                self.datasourceList.append(image)
                self.thumbNailTableView.reloadData()
            })
        })
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (datasourceList.isEmpty) ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ThumbNailCell
        cell.selectionStyle = .none
        cell.firstImageView.image = datasourceList[0]
        cell.secondImageView.image = datasourceList[1]
        return cell
    }
    
    func base64Image(imageString: String, completion: ((UIImage?) -> Void)?) {
        DispatchQueue.global(qos: .background).async {
            if let data = Data(base64Encoded: imageString) {
                if let image = UIImage(data: data) {
                    if let completion = completion {
                        DispatchQueue.main.async {
                            completion(image)
                        }
                    }
                }
            }
        }
    }

}
