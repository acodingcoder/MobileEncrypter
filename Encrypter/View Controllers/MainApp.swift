
import Foundation
import UIKit


class MainAppView : GradientView {
    
    var statusbarView = UIView()
    var navbar = UIView()
    var galleryLabel = UILabel()
    var line = UIView()
    var lockButton = NavbarButtonLock()
    var addButton = NavbarButtonAdd()
    var tableView = UITableView()
    
    override func configureView() {
        addSubview(statusbarView)
        addSubview(navbar)
        addSubview(line)
        navbar.addSubview(galleryLabel)
        navbar.addSubview(lockButton)
        navbar.addSubview(addButton)
        addSubview(tableView)
        super.configureView()
        
        statusbarView.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 35/255, alpha: 1.0)
        navbar.backgroundColor = UIColor(red: 25/255, green: 25/255, blue: 35/255, alpha: 1.0)
        
        line.backgroundColor = .black
        
        galleryLabel.textColor = .white
        galleryLabel.textAlignment = .center
        galleryLabel.font = UIFont(name: "Futura", size: 24)
        galleryLabel.text = "Gallery"
        
        tableView.rowHeight = 80
        tableView.isScrollEnabled = true
        tableView.separatorInset.left = 0
        tableView.backgroundColor = .clear
        tableView.separatorColor = .gray
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        statusbarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        navbar.snp.makeConstraints { (make) in
            make.top.equalTo(statusbarView.snp.bottom)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
        }
        
        line.snp.makeConstraints { (make) in
            make.top.equalTo(navbar.snp.bottom)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        lockButton.allignLeft()
        
        addButton.allignRight()
        
        galleryLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview()
            make.left.equalTo(lockButton.snp.right)
            make.right.equalTo(addButton.snp.left)
            make.centerY.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(line.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
        }
    }
}


class MainApp : BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override var contentView: MainAppView {
        return view as! MainAppView
    }
    
    var image: UIImage!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
        contentView.tableView.register(imageViewCell.self, forCellReuseIdentifier: "imageViewCell")
    }
    
    override func loadView() {
        view = MainAppView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handleNavigation() {
        if (touchStartView is NavbarButtonAdd) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageData: Data = UIImagePNGRepresentation(pickedImage)!
            let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
            
            Defaults.imagesData.append(strBase64)
            Defaults.userManager.setImages()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}


extension MainApp : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Defaults.imagesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : imageViewCell = tableView.dequeueReusableCell(withIdentifier: "imageViewCell") as! imageViewCell
        cell.imageView?.image = Defaults.images[indexPath.row]
        cell.imageView?.scaleImage()
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class imageViewCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTableViewCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableViewCell() {
        backgroundColor = .clear
        
        var imageView = UIImageView()
        addSubview(imageView)
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(65)
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        imageView.layer.cornerRadius = 6
    }
}
