//
//  FetchGameInformation.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/21.
//

import Foundation
import Combine

struct gameInfo: Codable {
    let gameTitle: String
    let gamePlatform: String
    let gameEngine: String
    let gameGenre: String
    let gameDeveloper: String
    let gamePublisher: String
    let isEarlyAccess: Bool
    let gameReleasedDate: Int
    let gameWebsite: String
    let gameImageURL: String
    let gameDescription: String
}

struct loadGameAPI {
    let url = URL(string:"http://developer.prodbybitmap.com/bmp/game.json")!
    
    func loadGameInfo() -> AnyPublisher<[gameInfo], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map{ $0.data }
            .decode(type: [gameInfo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

class gameApiClient : ObservableObject {
    var cancellable: AnyCancellable?
    let api = loadGameAPI()
    
    func loadGameInfo(){
        cancellable = api.loadGameInfo()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let err):
                    print("failed \(err)")
                }
            }, receiveValue: { todos in
                print("receivedValue : todos: \(todos)")
            })
    }
    
}

class exampleGameInfo: Identifiable {
    var gameIndex: Int = 1
    var gameTitle: [String] = [
        "The Humanity",
        "OX"
    ]
    var gameDeveloper: [String] = [
        "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
        "Team. Assertive"
    ]
    var gameImage: [String] = [
        "TheHumanity",
        "OX"
    ]
    var gameDistributor: [String] = [
        "Interactive Installation, Bitmap Production",
        "ENTER, Bitmap Production"
    ]
    var gameHeadline: [String] = [
        "오늘 밤, 나는 떠날 것이다",
        "몰입형 퍼즐 게임 \'OX\'의 세계로"
    ]
    var gamePosterURL: [String] = [
        "http://www.prodbybitmap.com/w/images/9/99/TheHumanityPoster1.png",
        "http://www.prodbybitmap.com/w/images/f/f9/OX_CMYK.JPG"
    ]
    var gameDescription: [String] = [
        "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발\n기술이 고도화됨에 따라 가상세계를 구축하려는 수많은 움직임이 보이고 있는 현재. SF 영화나 소설에서 볼 수 있던 사이버 세계가 더 이상 공상에서만 존재하는 것이 아닌, 현실에서 실현되고 있음을 느낄 수 있다. 그렇다면 기계와 인간의 대등한 융합이 시도되는 미래 사이버펑크 세상을 상상하며 다음과 같은 질문을 던질 수 있을 것이다. \'과연 인간을 규정하고 있는 것은 무엇인가?\', \'인간성이란 무엇인가?\' \n우리는 인간 인식 능력의 두 원천 중 표상을 받아들이는 심성의 수용성, 즉 ‘감성’에 집중하였다. 칸트의 논리학에 의하면 인간의 인식 능력의 성질은 하나의 요소만으로는 불완전한 인식에 이르게 된다고 한다. 이에 인간과 달리 맹목적 본능이 결여된 기계적 입장을 플레이어로 설정하여, \'인간성\'을 갖추기 위해 필요한 감성을 탐구하는 과정을 담은 게임을 만들어보고자 하였다.",
        "서울예술대학교 디지털아트 페스티벌 \"ENTER\" 출품작. 김달, 김선진, 유현승, 이재혁, 정소연 개발\n메타버스가 발전한 미래의 양상을 자신과 자신의 메타버스 아바타를 통해 그려낸 게임이다. 자신과 자신의 메타버스 아바타의 대칭 이동을 활용하여 해결해 나가는 퍼즐 게임.\n\n아바타를 통한 자아 실현이 현실화된 현대에는 많은 사람들이 정형화되어 있는 자기 정체성을 탈피하고 흔히 \"부캐\" (강조)라고 일컫는 \"멀티 페르소나\" (강조)를 구축하고 있는 추세이다. 특히 가상 세계 속 아바타는 현실의 나를 대변하는 캐릭터이면서 동시에 나의 또 다른 자아의 가시적 형태라고도 볼 수 있다.\n그러나 일각에서는 자신이 만들어낸 허구적 역할에 지나치게 몰입함으로서 발생하는 자아 상실과 자아 정체성의 혼란에 대한 우려가 제시되었다. 이에 몰입 환경에서의 가상과 현실의 모호함, 그로 인해 발생할 수 있는 가상 세계 이입의 어두운 양상을 시사하는 작품이다.\nOX는 자기 자신과 자신이 만들어낸 또 다른 자신 사이에서 자신의 주체에 대한 스스로의 판단을 의미힌다. 게임 내에서 플레이어에게 의도적인 무지를 제공하고, 믿을 수 없는 화자의 연출을 빌린 아이러니를 통해 주체에 대한 혼동을 야기하고 플레이어의 관념을 환기시킨다."
    ]
    var isInstalled: [Bool] = [
        true,
        true]
}
