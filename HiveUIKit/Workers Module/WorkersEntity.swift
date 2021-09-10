//
//  WorkersEntity.swift
//  HiveUIKit
//
//  Created by Denis Svetlakov on 29.04.2021.
//  Copyright © 2021 Denis Svetlakov. All rights reserved.
//

import Foundation

struct Workers: Decodable {
    let data: [Worker]?
    
    init(data: [Worker]) {
        self.data = data
    }
}

struct Worker: Decodable, Hashable {
    
    let id, platform: Int?
    let name, description: String?
    let unitsCount: Int?
    let active: Bool?
    let password: String?
    let tagIDS: [Int]?
    let mirrorURL: String?
    let redTemp, redMemTemp, redCPUTemp, redBoardTemp: Int?
    let redFan, redASR: Int?
    let redLa: Double?
    let redHashrates: [RedHashrate]?
    let ipAddresses: [String]?
    let remoteAddress: RemoteAddress?
    let vpn, hasAMD, hasNvidia, needsUpgrade: Bool?
    let packagesHash: String?
    let lanConfig: LANConfig?
    let hasOctofan, hasCoolbox, hasFanflap, hasPowermeter: Bool?
    let versions: Versions?
    let stats: PurpleStats?
    let flightSheet: FlightSheet?
    let overclock: Overclock?
    let tunedMiners: [String]?
    let minersSummary: MinersSummary?
    let minersStats: MinersStats?
    let hardwareInfo: HardwareInfo?
    let hardwareStats: HardwareStats?
    let gpuSummary: GPUSummary?
    let gpuInfo: [GPUInfo]?
    let gpuStats: [GPUStat]?
    let asicInfo: ASICInfo?
    let asicStats: ASICStats?
    let messages: [Message]?
//    let watchdog: Watchdog?
    let options: Options?
    let hardwarePowerDraw, psuEfficiency: Int?
    let octofanCorrectPower: Bool?
    let autofan: Autofan?
    let octofan: Octofan?
    let coolbox: Coolbox?
    let coolboxInfo: CoolboxInfo?
    let fanflap: Fanflap?
    let fanflapStats: FanflapStats?
    let powermeter: Powermeter?
    let powermeterStats: PowermeterStats?
    let commands: [Command]?
    let benchmarkID: Int?
    let asicConfig: ASIC?

    enum CodingKeys: String, CodingKey {
        case id, platform, name, description
        case unitsCount = "units_count"
        case active, password
        case tagIDS = "tag_ids"
        case mirrorURL = "mirror_url"
        case redTemp = "red_temp"
        case redMemTemp = "red_mem_temp"
        case redCPUTemp = "red_cpu_temp"
        case redBoardTemp = "red_board_temp"
        case redFan = "red_fan"
        case redASR = "red_asr"
        case redLa = "red_la"
        case redHashrates = "red_hashrates"
        case ipAddresses = "ip_addresses"
        case remoteAddress = "remote_address"
        case vpn
        case hasAMD = "has_amd"
        case hasNvidia = "has_nvidia"
        case needsUpgrade = "needs_upgrade"
        case packagesHash = "packages_hash"
        case lanConfig = "lan_config"
        case hasOctofan = "has_octofan"
        case hasCoolbox = "has_coolbox"
        case hasFanflap = "has_fanflap"
        case hasPowermeter = "has_powermeter"
        case versions, stats
        case flightSheet = "flight_sheet"
        case overclock
        case tunedMiners = "tuned_miners"
        case minersSummary = "miners_summary"
        case minersStats = "miners_stats"
        case hardwareInfo = "hardware_info"
        case hardwareStats = "hardware_stats"
        case gpuSummary = "gpu_summary"
        case gpuInfo = "gpu_info"
        case gpuStats = "gpu_stats"
        case asicInfo = "asic_info"
        case asicStats = "asic_stats"
        case messages, options
//        case watchdog
        case hardwarePowerDraw = "hardware_power_draw"
        case psuEfficiency = "psu_efficiency"
        case octofanCorrectPower = "octofan_correct_power"
        case autofan, octofan
        case coolbox
        case coolboxInfo = "coolbox_info"
        case fanflap
        case fanflapStats = "fanflap_stats"
        case powermeter
        case powermeterStats = "powermeter_stats"
        case commands
        case benchmarkID = "benchmark_id"
        case asicConfig = "asic_config"
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
        static func == (lhs: Worker, rhs: Worker) -> Bool {
            return lhs.id == rhs.id
        }
}

struct ASIC: Codable {
    let additionalProp1, additionalProp2, additionalProp3: String?
}

struct ASICInfo: Codable {
    let model, logicVersion, firmware: String?

    enum CodingKeys: String, CodingKey {
        case model
        case logicVersion = "logic_version"
        case firmware
    }
}

struct ASICStats: Codable {
    let fans: [Fan]?
    let fansCount: Int?
    let boards: [Board]?
    let asicboost: Bool?

    enum CodingKeys: String, CodingKey {
        case fans
        case fansCount = "fans_count"
        case boards, asicboost
    }
}

struct Board: Codable {
    let chain, acn: Int?
    let freq: Double?
    let status: [Int]?
    let temp, boardTemp, hwErrors: Int?
    let power, chainVoltage: Double?

    enum CodingKeys: String, CodingKey {
        case chain, acn, freq, status, temp
        case boardTemp = "board_temp"
        case hwErrors = "hw_errors"
        case power
        case chainVoltage = "chain_voltage"
    }
}

struct Fan: Codable {
    let index, fan, fanRPM: Int?

    enum CodingKeys: String, CodingKey {
        case index, fan
        case fanRPM = "fan_rpm"
    }
}

struct Autofan: Codable {
    let enabled: Bool?
    let targetTemp, targetMemTemp, minFan, maxFan: Int?
    let criticalTemp: Int?
    let criticalTempAction: String?
    let noAMD, rebootOnErrors, smartMode: Bool?

    enum CodingKeys: String, CodingKey {
        case enabled
        case targetTemp = "target_temp"
        case targetMemTemp = "target_mem_temp"
        case minFan = "min_fan"
        case maxFan = "max_fan"
        case criticalTemp = "critical_temp"
        case criticalTempAction = "critical_temp_action"
        case noAMD = "no_amd"
        case rebootOnErrors = "reboot_on_errors"
        case smartMode = "smart_mode"
    }
}

struct Command: Codable {
    let command: String?
    let id: Int?
    let data: PurpleData?
}

struct PurpleData: Codable {
}

struct Coolbox: Codable {
    let fan: Int?
    let auto: Bool?
    let targetTemp: Int?
    let wdEnabled: Bool?
    let wdInterval: Int?

    enum CodingKeys: String, CodingKey {
        case fan, auto
        case targetTemp = "target_temp"
        case wdEnabled = "wd_enabled"
        case wdInterval = "wd_interval"
    }
}

struct CoolboxInfo: Codable {
    let version, revision: String?
}

//struct Stats: Codable {
//    let casefan, thermosensors: [Int]
//}

struct Fanflap: Codable {
    let fan: Int?
    let auto: Bool?
    let targetTemp, minFan, maxFan: Int?

    enum CodingKeys: String, CodingKey {
        case fan, auto
        case targetTemp = "target_temp"
        case minFan = "min_fan"
        case maxFan = "max_fan"
    }
}

struct FanflapStats: Codable {
    let fan: [Int]?
}

struct FlightSheet: Codable {
    let id, farmID, userID: Int?
    let name: String?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case id
        case farmID = "farm_id"
        case userID = "user_id"
        case name, items
    }
}

struct Item: Codable {
    let coin, pool: String?
    let walID: Int?
    let dcoin, dpool: String?
    let dwalID: Int?
    let miner, minerAlt: String?

    enum CodingKeys: String, CodingKey {
        case coin, pool
        case walID = "wal_id"
        case dcoin, dpool
        case dwalID = "dwal_id"
        case miner
        case minerAlt = "miner_alt"
    }
}

struct GPUInfo: Codable {
    let busID: String?
    let busNumber: Int?
    let brand, model, shortName: String?
    let details: Details?
    let powerLimit: PowerLimit?
    let index: Int?

    enum CodingKeys: String, CodingKey {
        case busID = "bus_id"
        case busNumber = "bus_number"
        case brand, model
        case shortName = "short_name"
        case details
        case powerLimit = "power_limit"
        case index
    }
}

struct Details: Codable {
    let mem: String?
    let memGB: Int?
    let memType, memOEM, vbios, subvendor: String?
    let oem: String?

    enum CodingKeys: String, CodingKey {
        case mem
        case memGB = "mem_gb"
        case memType = "mem_type"
        case memOEM = "mem_oem"
        case vbios, subvendor, oem
    }
}

struct PowerLimit: Codable {
    let min, def, max: String?
}

struct GPUStat: Codable {
    let busNumber, temp, fan, power: Int?
    let coreclk, memclk, memtemp: Int?
    let busID: String?
    let isOverheated: Bool?
    let hash: Double?

    enum CodingKeys: String, CodingKey {
        case busNumber = "bus_number"
        case busID = "bus_id"
        case temp, fan, power, coreclk, memclk, memtemp, hash
        case isOverheated = "is_overheated"
    }
}

struct GPUSummary: Codable {
    let gpus: [Gpus]?
    let maxTemp, maxFan: Int?

    enum CodingKeys: String, CodingKey {
        case gpus
        case maxTemp = "max_temp"
        case maxFan = "max_fan"
    }
}

struct Gpus: Codable {
    let name: String?
    let amount: Int?
}

struct HardwareInfo: Codable {
    let motherboard: Motherboard?
    let cpu: CPU?
    let disk: Disk?
    let netInterfaces: [NetInterface]?

    enum CodingKeys: String, CodingKey {
        case motherboard, cpu, disk
        case netInterfaces = "net_interfaces"
    }
}

struct CPU: Codable {
    let id, model: String?
    let cores: Int?
    let aes: Bool?
}

struct Disk: Codable {
    let model: String?
}

struct Motherboard: Codable {
    let manufacturer, model, bios: String?
}

struct NetInterface: Codable {
    let iface, mac: String?
}

struct HardwareStats: Codable {
    let df: String?
    let cpuavg: [Double]?
    let cputemp: [Int]?
    let cpuCores: Int?
    let memory: Memory?

    enum CodingKeys: String, CodingKey {
        case df, cpuavg, cputemp
        case cpuCores = "cpu_cores"
        case memory
    }
}

struct Memory: Codable {
    let total, free: Int?
}

struct LANConfig: Codable {
    let dhcp: Bool?
    let address, gateway, dns: String?
}

struct Message: Codable {
    let id: Int?
    let title, type: String?
    let time, cmdID: Int?
    let command: String?
    let commandResult: PurpleData?
    let hasPayload: Bool?

    enum CodingKeys: String, CodingKey {
        case id, title, type, time
        case cmdID = "cmd_id"
        case command
        case commandResult = "command_result"
        case hasPayload = "has_payload"
    }
}

struct MinersStats: Codable {
    let hashrates: [MinersStatsHashrate]?
}

struct MinersStatsHashrate: Codable {
    let miner, algo, coin: String?
    let hashes: [Double]?
    let dalgo, dcoin: String?
    let dhashes, temps, fans, invalidShares: [Int]?
    let busNumbers, dbusNumbers: [Int]?

    enum CodingKeys: String, CodingKey {
        case miner, algo, coin, hashes, dalgo, dcoin, dhashes, temps, fans
        case invalidShares = "invalid_shares"
        case busNumbers = "bus_numbers"
        case dbusNumbers = "dbus_numbers"
    }
}

struct MinersSummary: Codable {
    let hashrates: [MinersSummaryHashrate]?
}

struct MinersSummaryHashrate: Codable {
    let miner, ver, algo, coin: String?
    let hash: Double?
    let dalgo, dcoin: String?
    let dhash: Int?
    let shares: Shares?
}

struct Shares: Codable {
    let accepted, rejected, invalid: Int?
    let ratio: Double?
}

struct Octofan: Codable {
    let fan: Int?
    let auto: Bool?
    let targetTemp, minFan, maxFan: Int?
    let blinkOnErrors, blinkToFind: Bool?
    let fan1MaxRPM, fan2MaxRPM, fan3MaxRPM, fan1Port: Int?
    let fan2Port, fan3Port: Int?

    enum CodingKeys: String, CodingKey {
        case fan, auto
        case targetTemp = "target_temp"
        case minFan = "min_fan"
        case maxFan = "max_fan"
        case blinkOnErrors = "blink_on_errors"
        case blinkToFind = "blink_to_find"
        case fan1MaxRPM = "fan1_max_rpm"
        case fan2MaxRPM = "fan2_max_rpm"
        case fan3MaxRPM = "fan3_max_rpm"
        case fan1Port = "fan1_port"
        case fan2Port = "fan2_port"
        case fan3Port = "fan3_port"
    }
}

struct Options: Codable {
    let disableGUI: Bool?
    let maintenanceMode, pushInterval, minerDelay, doh: Int?
    let powerCycle: Bool?

    enum CodingKeys: String, CodingKey {
        case disableGUI = "disable_gui"
        case maintenanceMode = "maintenance_mode"
        case pushInterval = "push_interval"
        case minerDelay = "miner_delay"
        case doh
        case powerCycle = "power_cycle"
    }
}

struct Overclock: Codable {
    let algo: String?
    let amd: AMD?
    let nvidia: Nvidia?
    let asic: ASIC?
}

struct AMD: Codable {
    let coreClock, coreState, coreVddc, memClock: String?
    let memState, memMvdd, memVddci, fanSpeed: String?
    let powerLimit: String?
    let aggressive: Bool?

    enum CodingKeys: String, CodingKey {
        case coreClock = "core_clock"
        case coreState = "core_state"
        case coreVddc = "core_vddc"
        case memClock = "mem_clock"
        case memState = "mem_state"
        case memMvdd = "mem_mvdd"
        case memVddci = "mem_vddci"
        case fanSpeed = "fan_speed"
        case powerLimit = "power_limit"
        case aggressive
    }
}

struct Nvidia: Codable {
    let coreClock, memClock, fanSpeed, powerLimit: String?
    let logoOff, ohgodapill: Bool?
    let ohgodapillStartTimeout: Int?
    let ohgodapillArgs: String?
    let runningDelay: Int?

    enum CodingKeys: String, CodingKey {
        case coreClock = "core_clock"
        case memClock = "mem_clock"
        case fanSpeed = "fan_speed"
        case powerLimit = "power_limit"
        case logoOff = "logo_off"
        case ohgodapill
        case ohgodapillStartTimeout = "ohgodapill_start_timeout"
        case ohgodapillArgs = "ohgodapill_args"
        case runningDelay = "running_delay"
    }
}

struct Powermeter: Codable {
    let meters: [Meter]?
}

struct Meter: Codable {
    let url, user, pass: String?
}

struct PowermeterStats: Codable {
    let power: [[Double]]?
    let powerTotal, energyTotal: [Double]?

    enum CodingKeys: String, CodingKey {
        case power
        case powerTotal = "power_total"
        case energyTotal = "energy_total"
    }
}

struct RedHashrate: Codable {
    let algo: String?
    let hashrate: Int?
}

struct RemoteAddress: Codable {
    let ip, hostname: String?
}

struct PurpleStats: Codable {
    let online: Bool?
    let bootTime, statsTime, minerStartTime, gpusOnline: Int?
    let gpusOffline, gpusOverheated, cpusOffline, boardsOnline: Int?
    let boardsOffline, boardsOverheated, powerDraw: Int?
    let overheated, overloaded, invalid, lowASR: Bool?

    enum CodingKeys: String, CodingKey {
        case online
        case bootTime = "boot_time"
        case statsTime = "stats_time"
        case minerStartTime = "miner_start_time"
        case gpusOnline = "gpus_online"
        case gpusOffline = "gpus_offline"
        case gpusOverheated = "gpus_overheated"
        case cpusOffline = "cpus_offline"
        case boardsOnline = "boards_online"
        case boardsOffline = "boards_offline"
        case boardsOverheated = "boards_overheated"
        case powerDraw = "power_draw"
        case overheated, overloaded, invalid
        case lowASR = "low_asr"
    }
}

struct Versions: Codable {
    let hive, systemType, kernel, amdDriver: String?
    let nvidiaDriver: String?

    enum CodingKeys: String, CodingKey {
        case hive
        case systemType = "system_type"
        case kernel
        case amdDriver = "amd_driver"
        case nvidiaDriver = "nvidia_driver"
    }
}

//struct Watchdog: Codable {
//    let enabled: Bool?
//    let restartTimeout, rebootTimeout: Int?
//    let checkPower, checkConnection: Bool?
//    let minPower, maxPower: Int?
//    let powerAction: String?
//    let checkGPU: Bool?
//    let maxLa: Int?
//    let options: [Option]?
//
//    enum CodingKeys: String, CodingKey {
//        case enabled
//        case restartTimeout = "restart_timeout"
//        case rebootTimeout = "reboot_timeout"
//        case checkPower = "check_power"
//        case checkConnection = "check_connection"
//        case minPower = "min_power"
//        case maxPower = "max_power"
//        case powerAction = "power_action"
//        case checkGPU = "check_gpu"
//        case maxLa = "max_la"
//        case options
//    }
//}
//
//struct Option: Codable {
//    let miner: String?
//    let minhash: Int?
//    let units: String?
//}
//
//struct Tag: Codable {
//    let id: Int?
//    let name: String?
//    let color, farmsCount, workersCount: Int?
//    let isAuto: Bool?
//    let farmID, userID: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, color
//        case farmsCount = "farms_count"
//        case workersCount = "workers_count"
//        case isAuto = "is_auto"
//        case farmID = "farm_id"
//        case userID = "user_id"
//    }
//}

class CardType {
    
    let card: String
    let brand: String
    let qty: String
    
    init(card: String, brand: String, qty: String) {
        self.card = card
        self.brand = brand
        self.qty = qty
    }
}

