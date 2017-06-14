//
//  ViewController.swift
//  testCollectionView
//
//  Created by Takuya on 2017/06/14.
//  Copyright © 2017 Takuya. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var myImage: UIImageView!
    
    var fetchResult_tmp: PHFetchResult<PHAsset>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //データの個数を返すメソッド
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: fetchOptions)
        
        fetchResult_tmp = fetchResult
        
        //number of images in the photo lib
        print("Num of images ---> ", fetchResult.count)
        return fetchResult.count
    }
    
    //データを返すメソッド
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //コレクションビューから識別子「cell」のセルを取得する。
        //let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCollectionCell
        
        //セルの背景色をランダムに設定する。
        cell.backgroundColor = UIColor(red: CGFloat(drand48()),
                                       green: CGFloat(drand48()),
                                       blue: CGFloat(drand48()),
                                       alpha: 1.0)
        
        let imgAsset = fetchResult_tmp.object(at: indexPath.row)
        PHImageManager().requestImage(for: imgAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: {(image, info)in
            print("...got image...")
            
            //self.imgThumbnail = UIImageView(image: result)
            cell.myImageView.image = image
            print("...got image...end")
        })
        
        return cell
        
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectedItemAt --> ", indexPath)

        //
        //MARK: フォトライブラリーから特定のイメージを取り出して表示する
        //
        let imgAsset = fetchResult_tmp.object(at: indexPath.row)
        PHImageManager().requestImage(for: imgAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: {(image, info)in
            print("...got image...")
            
            self.myImage.image = image
            print("...got image...end")
        })
        
        /*
        PHImageManager().requestImage(for: lastImageAsset, targetSize: PHImageManagerMaximumSize, contentMode: PHImageContentMode.aspectFill, options: nil, resultHandler: {(image, info)in
            print("...got image...")
            print(info)
            
            //self.imgThumbnail = UIImageView(image: result)
            self.imgThumb.image = image
            
            print("...got image...end")
        })
        */
        //collectionView.setContentOffset(<#T##contentOffset: CGPoint##CGPoint#>, animated: <#T##Bool#>)
        collectionView.scrollToItem(at: <#T##IndexPath#>, at: <#T##UICollectionViewScrollPosition#>, animated: <#T##Bool#>)
    }
    //func coll
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        print("shouldSelectItemAt")
        return true
    }
}

