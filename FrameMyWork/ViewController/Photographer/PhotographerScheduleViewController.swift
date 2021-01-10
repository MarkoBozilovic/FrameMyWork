//
//  PhotographerScheduleViewController.swift
//  FrameMyWork
//
//  Created by Marko Bozilovic on 20.12.20..
//

import UIKit

class PhotographerScheduleViewController: UIViewController,
                                          UICollectionViewDataSource,
                                          UICollectionViewDelegate,
                                          UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    
    @IBOutlet var monthYearLabel: UILabel!
    @IBOutlet var weekdayCollectionLabel: [UILabel]!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    
    let photographer = Model.shared.user!.profile as! Photographer
    var dataSource = FMWCalendar.shared.getArrayOfDaysInMonth()

    // MARK: - LifeCycleFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOutlets()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView!.collectionViewLayout = layout
    }
    
    // MARK: - Actions
    
    @IBAction func nextPressed() {
        monthYearLabel.text = "\(FMWCalendar.shared.getNextMonth()) \(FMWCalendar.shared.getCurrentYear())"
        updateDataSource()
        
    }
    
    @IBAction func previousPressed() {
        monthYearLabel.text = "\(FMWCalendar.shared.getPreviousMonth()) \(FMWCalendar.shared.getCurrentYear())"
        updateDataSource()
    }
    
    // MARK: - Functions
    
    func setupOutlets() {
        // setup weekday labels
        for index in weekdayCollectionLabel.indices {
            weekdayCollectionLabel[index].text = FMWCalendar.calendar.shortWeekdaySymbols[index]
        }
        
        // setup month and year label
        monthYearLabel.text = "\(FMWCalendar.shared.getCurrentMonth()) \(FMWCalendar.shared.getCurrentYear())"
    }
    
    func updateDataSource() {
        dataSource = FMWCalendar.shared.getArrayOfDaysInMonth()
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateIdentifier",
                                                      for: indexPath) as! DateCollectionViewCell
        cell.dateLabel.text = "\(dataSource[indexPath.row])"
        if cell.dateLabel.text == "" {
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }

}
