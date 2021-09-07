//
//  MetricsCell.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 03.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit
import Charts

class MetricsCell: UICollectionViewCell {
    
    let gradientBackgroundView = GradientView(from: .topLeading, to: .bottomTrailing, startColor: #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 0.29169934), endColor: #colorLiteral(red: 0.7921568627, green: 0.7921568627, blue: 0.7921568627, alpha: 0.5486825097))
    
    var algo: String?
    lazy var hashBarChartView: BarChartView = {
        let view = BarChartView()
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect) {
        super.init (frame: frame)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeViews()
        setupCardView()
        setupConstraints()
    }
    
    func bind(_ item: FormComponent) {
        guard let item = item as? MetricsItem else { return }
        setup(item: item)
    }
    
    func setupConstraints() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(hashBarChartView)
        contentView.addSubview(gradientBackgroundView)
        
        gradientBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        hashBarChartView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            gradientBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradientBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradientBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            gradientBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hashBarChartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            hashBarChartView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hashBarChartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            hashBarChartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}

extension MetricsCell {
    
    func setup(item: MetricsItem) {
        self.algo = item.metrics.algo
    }
    
    func buildChart(metrics: MetricsModel?) {
        
        // Getting values for the hashrate bar chart
        var entries = [BarChartDataEntry]()
        
        guard let metrics = metrics else { return }
        metrics.data.forEach { point in
                    point.hashrates.forEach {
                        if $0.algo == self.algo {
                            entries.append(BarChartDataEntry(x:(Double(point.time) / 300),
                                                          y: (Double($0.values.reduce(0, +)) / 1000000)))
                        }
                    }
                }
        
        hashBarChartView.rightAxis.enabled = false
        
        // Setup Y axis
        let yAxis = hashBarChartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 10)
        yAxis.setLabelCount(4, force: true)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .green
        yAxis.labelPosition = .outsideChart
        yAxis.axisMinimum = 0
        
        // Setup X axis
        hashBarChartView.xAxis.labelPosition = .bottom
        hashBarChartView.xAxis.labelFont = .boldSystemFont(ofSize: 6)
        hashBarChartView.xAxis.setLabelCount(4, force: true)
        hashBarChartView.xAxis.labelTextColor = .white
        hashBarChartView.xAxis.axisLineColor = .green
        
        // Format X values as date
        hashBarChartView.xAxis.valueFormatter = XAxisValuesFormatter()
        
        let set = BarChartDataSet(entries: entries, label: "\(self.algo ?? "")")
        set.setColor(.green)

        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        
        hashBarChartView.data = data
    }
    
}
