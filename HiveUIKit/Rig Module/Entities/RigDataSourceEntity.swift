//
//  RigDataSourceModel.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 02.09.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

// Protocols defines relations of the section and items in sections
protocol FormItem {
    var id: UUID { get }
}

protocol FormSectionItem {
    var id: UUID { get }
    var items: [FormComponent] { get }
    init(items: [FormComponent])
}

// Father class of each section
final class FormSectionComponent: FormSectionItem, Hashable {
    
    var id: UUID = UUID()
    var items: [FormComponent]
    
    init(items: [FormComponent]) {
        self.items = items
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: FormSectionComponent, rhs: FormSectionComponent) -> Bool {
        lhs.id == rhs.id
    }
}

class FormComponent: FormItem, Hashable {
    
    var id: UUID = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: FormComponent, rhs: FormComponent) -> Bool {
        lhs.id == rhs.id
    }
}


final class RigItem: FormComponent {
    let rig: Worker
    let messages: [Messages]
    
    init(rig: Worker, messages: [Messages]) {
        self.rig = rig
        self.messages = messages
    }
}

final class GpuItem: FormComponent {
    let worker: GPUStat
    
    init(worker: GPUStat) {
        self.worker = worker
    }
}

final class MetricsItem: FormComponent {
    let metrics: Hash
    
    init(metrics: Hash) {
        self.metrics = metrics
    }
}

final class GeneralWorkerInfo: FormComponent {
    let info: Worker
    
    init(info: Worker) {
        self.info = info
    }
}

