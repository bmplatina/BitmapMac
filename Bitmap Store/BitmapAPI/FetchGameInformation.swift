//
//  FetchGameInformation.swift
//  Bitmap Store
//
//  Created by 재혁 on 2022/07/21.
//

import Foundation

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
    var gameDescription: [String] = [
        "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발",
        "서울예술대학교 디지털아트 페스티벌 \"ENTER\" 출품작. 김달, 김선진, 유현승, 이재혁, 정소연 개발\n메타버스가 발전한 미래의 양상을 자신과 자신의 메타버스 아바타를 통해 그려낸 게임이다. 자신과 자신의 메타버스 아바타의 대칭 이동을 활용하여 해결해 나가는 퍼즐 게임.\n\n아바타를 통한 자아 실현이 현실화된 현대에는 많은 사람들이 정형화되어 있는 자기 정체성을 탈피하고 흔히 \"부캐\" (강조)라고 일컫는 \"멀티 페르소나\" (강조)를 구축하고 있는 추세이다. 특히 가상 세계 속 아바타는 현실의 나를 대변하는 캐릭터이면서 동시에 나의 또 다른 자아의 가시적 형태라고도 볼 수 있다.\n그러나 일각에서는 자신이 만들어낸 허구적 역할에 지나치게 몰입함으로서 발생하는 자아 상실과 자아 정체성의 혼란에 대한 우려가 제시되었다. 이에 몰입 환경에서의 가상과 현실의 모호함, 그로 인해 발생할 수 있는 가상 세계 이입의 어두운 양상을 시사하는 작품이다.\nOX는 자기 자신과 자신이 만들어낸 또 다른 자신 사이에서 자신의 주체에 대한 스스로의 판단을 의미힌다. 게임 내에서 플레이어에게 의도적인 무지를 제공하고, 믿을 수 없는 화자의 연출을 빌린 아이러니를 통해 주체에 대한 혼동을 야기하고 플레이어의 관념을 환기시킨다."
    ]
    var isInstalled: [Bool] = [
        false,
        true]
}
