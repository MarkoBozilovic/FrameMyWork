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
    let calendar = FMWCalendar.shared

    // MARK: - LifeCycleFunctions
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupOutlets()
    }
    
    // MARK: - Actions
    
    @IBAction func nextPressed() {
        calendar.nextMonth()
        updateUI()
    }
    
    @IBAction func previousPressed() {
        calendar.previousMonth()
        updateUI()
    }
    
    func updateUI() {
        monthYearLabel.text = calendar.currentMonth
        collectionView.reloadData()
    }
    
    // MARK: - Functions
    
    func setupOutlets() {
        // setup weekday labels
        for index in weekdayCollectionLabel.indices {
            weekdayCollectionLabel[index].text = calendar.weekdaySymbols[index]
        }
        
        // setup month and year label
        monthYearLabel.text = calendar.currentMonth

        // setup collectionView layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: view.bounds.width / 7, height: view.bounds.width / 7)
        layout.sectionInset = .zero
        collectionView!.collectionViewLayout = layout
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        calendar.arrayOfDays.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateIdentifier",
                                                      for: indexPath) as! DateCollectionViewCell
        
        let calendarDate = calendar.arrayOfDays[indexPath.row]
        if calendarDate.date != nil {
            cell.dateLabel.text = calendar.formatDate(calendarDate.date!)
            cell.isHidden = false
            cell.isUserInteractionEnabled = true
        } else {
            cell.isHidden = true
            cell.isUserInteractionEnabled = false
        }
        
        if calendarDate.schedule != nil {
            cell.backgroundColor = .red
            cell.dateLabel.textColor = .white
            cell.setNeedsDisplay()
        } else {
            cell.backgroundColor = .white
            cell.dateLabel.textColor = .black
            cell.setNeedsDisplay()
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let date = calendar.arrayOfDays[indexPath.row]
        if date.schedule != nil {
            performSegue(withIdentifier: "scheduleIdentifier", sender: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "scheduleIdentifier" else { return }
        let destinationVC = segue.destination as! PhotographerScheduleDetailsViewController
        destinationVC.schedule = calendar.arrayOfDays[sender as! Int].schedule
    }

}
