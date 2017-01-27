//
//  ItemDetailsVC.swift
//  DreamList
//
//  Created by Dmytro Aprelenko on 24.01.17.
//  Copyright © 2017 Dmytro Aprelenko. All rights reserved.
//

import UIKit
import CoreData

class ItemDetailsVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var detailsTitle: UITextField!
    @IBOutlet weak var detailMeans: UITextField!
    @IBOutlet weak var detailsDescription: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var thumgImg: UIImageView!
    
    var stores = [Store]()
    var itemToEdit: Item?
    
    var imagePicker: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        picker.dataSource = self
        picker.delegate = self
        
//        let store = Store(context: context)
//        store.name = "GOgog"
//        ad.saveContext()
        
          getStores()
        
        if itemToEdit != nil {
            loadItemData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return stores.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // TODO: when selected
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let store = stores[row]
        return store.name
    }
    
    func getStores() {
        let fetchRequest: NSFetchRequest<Store> = Store.fetchRequest()
        do {
           self.stores = try context.fetch(fetchRequest)
            self.picker.reloadAllComponents()
        } catch {
            // TODO
        }
    }
    @IBAction func saveItem(_ sender: UIButton) {
        var item: Item!
        let picture = Image(context: context)
        
        if itemToEdit == nil {
            item = Item(context: context)
        } else {
            item = itemToEdit
        }
        
       
        
        if let title = detailsTitle.text {
            item.title = title
        }
        if let means = detailMeans.text {
            item.price = (means as NSString).doubleValue
        }
        if let description = detailsDescription.text {
            item.details = description
        }
        item.toStore = stores[picker.selectedRow(inComponent: 0)]
        picture.image = thumgImg.image
        item.toImage = picture
        ad.saveContext()
        _ = navigationController?.popViewController(animated: true)
    }

    func loadItemData () {
        if let item = itemToEdit {
            detailsTitle.text = item.title
            detailMeans.text = ("\(item.price)")
            detailsDescription.text = item.title
            thumgImg.image = item.toImage?.image as? UIImage
            
            if let store = item.toStore {
                 var index = 0
                repeat {
                    let s = stores[index]
                    if s.name == store.name {
                        picker.selectRow(index, inComponent: 0, animated: false)
                        break
                    }
                    index += 1
                } while index < stores.count 
            }
            
        }
    }
    
    @IBAction func deleteBut(_ sender: UIBarButtonItem) {
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popViewController(animated: true)
    }
    @IBAction func addImage(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            thumgImg.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
