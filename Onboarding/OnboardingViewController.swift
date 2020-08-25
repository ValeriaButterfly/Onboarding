//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Valeria Muldt on 25.08.2020.
//  Copyright © 2020 Valeria Muldt. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet {
            pageControl.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var nextButton: UIButton!
    
    let scrollView = UIScrollView()
    
    let titles = ["Предлагайте свою цену", "Выберите лучшее предложение", "Создайте регулярные поездки на работу и обратно", "Легко стать водителем"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configure()
    }
    
    private func configure() {
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)
        
        for x in 0..<4 {
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width, y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            // Title, image
            let label = UILabel(frame: CGRect(x: 10, y: 10, width: pageView.frame.size.width-20, height: 120))
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10+120+10, width: pageView.frame.size.width-20, height: pageView.frame.size.height - 130 - 15))
            label.textAlignment = .center
            label.font = UIFont(name: "Helvetica-Bold", size: 24)
            label.numberOfLines = 2
            pageView.addSubview(label)
            label.text = titles[x]
            
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "passenger_\(x+1)")
            pageView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width*4, height: 0)
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
    }
    
    private func setupButton() {
        if pageControl.currentPage == 3 {
            nextButton.setTitle("OKEY", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @IBAction func nextPageAction(_ sender: UIButton) {
        
        pageControl.currentPage += 1
        print(pageControl.currentPage)
        if nextButton.title(for: .normal) == "OKEY" {
            UserDefaults.standard.set(true, forKey: "isNewUser")
            dismiss(animated: true, completion: nil)
            return
        } else {
            scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(pageControl.currentPage), y: 0), animated: true)
            
            setupButton()
        }
    }
    
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndicatorForCurrentPage()
    }
    
    func setIndicatorForCurrentPage() {
        let page = scrollView.contentOffset.x/holderView.frame.size.width
        pageControl.currentPage = Int(page)
        
        setupButton()
    }
}
