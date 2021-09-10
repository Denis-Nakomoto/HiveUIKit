//
//  DetailedWorkerView.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 16.06.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import UIKit

class DetailedWorkerView: UIView, StacksAndViewsPreparableProtocol {
    
    let fanNameLabel = UILabel(text: "FAN", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var fanLabel = UILabel(text: "Fan", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let coreNameLabel = UILabel(text: "CORE", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var coreLabel = UILabel(text: "Core", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let memNameLabel = UILabel(text: "MEM", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var memLabel = UILabel(text: "Mem", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let plNameLabel = UILabel(text: "PL", font: .systemFont(ofSize: 14, weight: .regular), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    var plLabel = UILabel(text: "Pl", font: .systemFont(ofSize: 14, weight: .thin), color: #colorLiteral(red: 0, green: 0.8, blue: 0, alpha: 1))
    let workerOnlineLabel = UILabel(text: "BOOTED", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let workerOnline = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let minerOnlineLabel = UILabel(text: "MINER ONLINE", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let minerOnline = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let iPLabel = UILabel(text: "IP", font: .systemFont(ofSize: 16, weight: .regular), color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    let iP = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let hiveVersionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let hiveVersion = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    let linuxVersionImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
    let linuxVersion = UILabel(text: "", font: .systemFont(ofSize: 12, weight: .light), color: #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1))
    
    let driversStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    
    let minerInfoField = MinerInfoSubView()
    
    let allDetailedGpusStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 8)
    
    let typeOfGpuStack = UIStackView(arrangedSubviews: [], axis: .vertical, spacing: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWorkerDetailedView(with worker: Worker, workerBootTime: String?, minerBootTime: String?) {
        setupDatailedGPUView(with: worker, on: allDetailedGpusStack)
        // TODO AMD overclocking labels
        fanLabel.text = worker.overclock?.nvidia?.fanSpeed
        coreLabel.text = worker.overclock?.nvidia?.coreClock
        memLabel.text = worker.overclock?.nvidia?.memClock
        plLabel.text = worker.overclock?.nvidia?.powerLimit
        workerOnline.text = workerBootTime
        minerOnline.text = minerBootTime
        iP.text = worker.ipAddresses?.first
        if worker.active == false {
            minerOnlineLabel.text = "WORKER OFFLINE"
        }
        hiveVersion.text = worker.versions?.hive
        linuxVersion.text = worker.versions?.kernel
        setupDriversStack(with: worker, on: driversStack)
        typeOfGpuStackSetup(with: worker, on: typeOfGpuStack)
    }
    

    
    func setupConstraints() {
        
        fanNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        fanNameLabel.layer.opacity = 0.8
        coreNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        coreNameLabel.layer.opacity = 0.8
        memNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        memNameLabel.layer.opacity = 0.8
        plNameLabel.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.3137254902, blue: 0.1921568627, alpha: 1)
        plNameLabel.layer.opacity = 0.8
        let fanStack = UIStackView(arrangedSubviews: [fanNameLabel, fanLabel], axis: .horizontal, spacing: 4)
        let coreStack = UIStackView(arrangedSubviews: [coreNameLabel, coreLabel], axis: .horizontal, spacing: 4)
        let memStack = UIStackView(arrangedSubviews: [memNameLabel, memLabel], axis: .horizontal, spacing: 4)
        let plStack = UIStackView(arrangedSubviews: [plNameLabel, plLabel], axis: .horizontal, spacing: 4)
        let workerOnlineStack = UIStackView(arrangedSubviews: [workerOnlineLabel, workerOnline], axis: .horizontal, spacing: 4)
        let minerOnlineStack = UIStackView(arrangedSubviews: [minerOnlineLabel, minerOnline], axis: .horizontal, spacing: 4)
        let iPStack = UIStackView(arrangedSubviews: [iPLabel, iP], axis: .horizontal, spacing: 4)
        
        hiveVersionImage.image = UIImage(named: "HiveLogoWhite")
        hiveVersionImage.contentMode = .scaleAspectFit
        linuxVersionImage.image = UIImage(named: "LinuxLogo")
        linuxVersionImage.contentMode = .scaleAspectFit
        
        let hiveVersionStack = UIStackView(arrangedSubviews: [hiveVersionImage, hiveVersion], axis: .horizontal, spacing: 4)
        let linuxVersionStack = UIStackView(arrangedSubviews: [linuxVersionImage, linuxVersion], axis: .horizontal, spacing: 4)
        
        allDetailedGpusStack.translatesAutoresizingMaskIntoConstraints = false
        fanStack.translatesAutoresizingMaskIntoConstraints = false
        coreStack.translatesAutoresizingMaskIntoConstraints = false
        memStack.translatesAutoresizingMaskIntoConstraints = false
        plStack.translatesAutoresizingMaskIntoConstraints = false
        workerOnlineStack.translatesAutoresizingMaskIntoConstraints = false
        minerOnlineStack.translatesAutoresizingMaskIntoConstraints = false
        iPStack.translatesAutoresizingMaskIntoConstraints = false
        hiveVersionStack.translatesAutoresizingMaskIntoConstraints = false
        linuxVersionStack.translatesAutoresizingMaskIntoConstraints = false
        minerInfoField.translatesAutoresizingMaskIntoConstraints = false
        driversStack.translatesAutoresizingMaskIntoConstraints = false
        typeOfGpuStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(allDetailedGpusStack)
        allDetailedGpusStack.distribution = .fillEqually
        allDetailedGpusStack.alignment = .leading
        addSubview(fanStack)
        addSubview(coreStack)
        addSubview(memStack)
        addSubview(plStack)
        addSubview(workerOnlineStack)
        addSubview(minerOnlineStack)
        addSubview(iPStack)
        addSubview(hiveVersionStack)
        addSubview(linuxVersionStack)
        addSubview(minerInfoField)
        addSubview(driversStack)
        addSubview(typeOfGpuStack)
        
        NSLayoutConstraint.activate([
            minerInfoField.topAnchor.constraint(equalTo: topAnchor),
            minerInfoField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            minerInfoField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            minerInfoField.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            allDetailedGpusStack.topAnchor.constraint(equalTo: minerInfoField.bottomAnchor, constant: 10),
            allDetailedGpusStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            allDetailedGpusStack.widthAnchor.constraint(equalToConstant: 230),
            allDetailedGpusStack.heightAnchor.constraint(equalToConstant: 52)
        ])
        
        NSLayoutConstraint.activate([
            fanStack.topAnchor.constraint(equalTo: allDetailedGpusStack.bottomAnchor, constant: 8),
            fanStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            coreStack.topAnchor.constraint(equalTo: fanStack.bottomAnchor, constant: 8),
            coreStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            memStack.topAnchor.constraint(equalTo: coreStack.bottomAnchor, constant: 8),
            memStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            plStack.topAnchor.constraint(equalTo: memStack.bottomAnchor, constant: 8),
            plStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            workerOnlineStack.topAnchor.constraint(equalTo: plStack.bottomAnchor, constant: 8),
            workerOnlineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            minerOnlineStack.topAnchor.constraint(equalTo: workerOnlineStack.bottomAnchor, constant: 2),
            minerOnlineStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            iPStack.topAnchor.constraint(equalTo: workerOnlineStack.bottomAnchor, constant: 2),
            iPStack.leadingAnchor.constraint(equalTo: minerOnlineStack.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            hiveVersionStack.topAnchor.constraint(equalTo: minerOnlineStack.bottomAnchor, constant: 8),
            hiveVersionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            linuxVersionStack.topAnchor.constraint(equalTo: hiveVersionStack.bottomAnchor, constant: 8),
            linuxVersionStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            driversStack.leadingAnchor.constraint(equalTo: linuxVersionStack.trailingAnchor, constant: 16),
            driversStack.topAnchor.constraint(equalTo: linuxVersionStack.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            typeOfGpuStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            typeOfGpuStack.topAnchor.constraint(equalTo: linuxVersionStack.bottomAnchor, constant: 8)
        ])
    }
    
}
