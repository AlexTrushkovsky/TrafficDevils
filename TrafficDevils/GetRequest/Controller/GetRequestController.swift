//
//  GetRequestController.swift
//  TrafficDevils
//
//  Created by Алексей Трушковский on 03.05.2021.
//

import UIKit

class GetRequestController: UIViewController {

    @IBAction func backButtonAction(_ sender: UIButton!) {
        self.goTo(vc: .main)
    }
    
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        getData()
    }
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private let network = NetworkController()
    private var model: GetRequestModel?
    private var alert: CustomAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .clear
        self.tableView.showsVerticalScrollIndicator = false
        alert = CustomAlertController(vc: self)
        getData()
    }
    
    private func getData() {
        let result = network.fetchData(tableView: tableView)
        self.model = result.0
        if let error = result.1 {
            alert?.showErrorAlert(error: error)
        }
    }
    
    override func viewDidLayoutSubviews() {
        let height = topLabel.bounds.height * 0.35
        self.topLabel.font = UIFont.systemFont(ofSize: height, weight: .heavy)
    }
    
    private func configureCell(cell: PlacesCell, index: IndexPath) {
        let data = model?.places
        guard let place = data?[index.row] else { return }
        //cell.cityImage = place.image
        cell.cityLabel.text = place.city
        cell.countryLabel.text = place.country
        
        //MARK: - Getting image
        cell.cityImage!.image = UIImage(named: "placeholder")
        guard let url = place.image else { return }
        cell.cityImage?.loadImage(fromURL: url)
    }
    
    
}

//MARK: TableView methods
extension GetRequestController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfPlaces = model?.places?.count ?? 0
        return numberOfPlaces
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlacesCell") as! PlacesCell
        configureCell(cell: cell, index: indexPath)
        return cell
    }
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath){
        cell.backgroundColor = tableView.backgroundColor
        cell.contentView.backgroundColor = tableView.backgroundColor
    }
    
}

extension UIImageView {
    private func transition(toImage image: UIImage?) {
        UIView.transition(with: self,
                          duration: 0.3,
                          options: [.transitionCrossDissolve],
                          animations: {self.image = image },
                          completion: nil)
    }
    
    public func loadImage(fromURL url: String) {
        guard let imageUrl = URL(string: url) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: imageUrl)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.transition(toImage: image)
                }
            } else {
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        DispatchQueue.main.async {
                            self.transition(toImage: image)
                        }
                    }
                }).resume()
            }
        }
    }
    
}

extension GetRequestController: CustomAlertDelegate {
    func cancelAction() {
        alert?.dismissAlert(animated: true)
    }
    
    func okAction() {
        getData()
        alert?.dismissAlert(animated: false)
    }
    
    
}
