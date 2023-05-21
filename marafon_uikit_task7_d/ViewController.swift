
import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let imageView: UIImageView = {
        let logoImage = UIImageView(image: UIImage(named: "1"))
        logoImage.contentMode = .scaleAspectFill
        logoImage.clipsToBounds = true
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        scroll.alwaysBounceVertical = true
        scroll.backgroundColor = .white
        scroll.keyboardDismissMode = .onDrag
        scroll.delegate = self
        return scroll
    }()
    
    lazy var imageHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 240)
    
    lazy var imageTopConstraint = imageView.topAnchor.constraint(equalTo: containerView.topAnchor)
    lazy var imageBottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.topAnchor)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubview()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    
    // MARK: - Создание и настройка интерфейса
    
    func setupViews() {
        view.backgroundColor = .white
    }
    
    func addSubview() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(imageView)
    }
    
    func setupConstraints() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 3000).isActive = true
        
        imageTopConstraint.isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        
        imageHeightConstraint.isActive = true
    }
    
    @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let defaultTop = CGFloat(0)
        var currentTop = defaultTop
        let barHeight = navigationController?.navigationBar.frame.height ?? 0
        
        if offset < 0 {
            currentTop = offset
            imageHeightConstraint.constant = 240 - offset
            scrollView.verticalScrollIndicatorInsets.top = 240 - offset - barHeight
        } else {
            imageHeightConstraint.constant = 240
            scrollView.verticalScrollIndicatorInsets.top = 240 - barHeight
        }
        imageTopConstraint.constant = currentTop
        
    }

}
