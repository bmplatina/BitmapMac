# Bitmap Application: Team Bitmap Web Application and ESD for macOS
README supports English and Korean / README 파일은 영어와 한국어를 지원합니다. 한국어 설명은 아래를 참조하세요.
This project is deprecated because due to cross platform support. Please visit [bmplatina/bitmap-electron-app][https://github.com/bmplatina/bitmap-electron-app].
이 프로젝트는 크로스 플랫폼 지원을 위해 폐기되었습니다. [bmplatina/bitmap-electron-app][https://github.com/bmplatina/bitmap-electron-app]을 참조해주세요.

## English Description
Welcome to Bitmap! We're preparing service platform for our teammates, and free ESD (Electronic Software Distribution) for everyone. Hope you're interested in.

### Getting started
#### Prerequisites
- Any macOS devices such as MacBook, Mac mini, Mac Studio, iMac, Mac Pro that is running macOS Big Sur or newer.

##### Download from GitHub releases
You can visit GitHub [Release page](https://github.com/bmplatina/BitmapMac/releases) to download.

##### Build from source
First, you'll need:
- Xcode 13 beta or newer
- Xcode Commandline Tools
- macOS devices which is running macOS Ventura beta

Second, open terminal and type:
```bash
cd ~/Documents/Xcode/ # Change directory that you want to clone this repository.
git clone https://github.com/bmplatina/BitmapMac/
```

Third, run Xcode and open this project and build it!

##### Get from Homebrew
Homebrew cask is under construction. Not supported yet.

### API
Bitmap ESD fetches data from json syntax provided by server. To make your own API, you should make some additional changes:

#### Game
game.json
- Make an array, put consistent elements like this:
```json
{
    "games": [
        {
            "gameIndex": 0,
            "gameTitle": "The Humanity",
            "gamePlatform": "Windows, macOS",
            "gameEngine": "Unity",
            "gameGenre": "어드벤처",
            "gameDeveloper": "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
            "gamePublisher": "Bitmap Production",
            "isEarlyAccess": true,
            "gameReleasedDate": 20211210,
            "gameWebsite": "http://prodbybitmap.com/wiki/The%20Humanity",
            "gameImageURL": "http://www.prodbybitmap.com/w/images/9/99/TheHumanityPoster1.png",
            "gameHeadline": "오늘 밤, 나는 떠날 것이다",
            "gameDescription": "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발\n기술이 고도화됨에 따라 가상세계를 구축하려는 수많은 움직임이 보이고 있는 현재. SF 영화나 소설에서 볼 수 있던 사이버 세계가 더 이상 공상에서만 존재하는 것이 아닌, 현실에서 실현되고 있음을 느낄 수 있다. 그렇다면 기계와 인간의 대등한 융합이 시도되는 미래 사이버펑크 세상을 상상하며 다음과 같은 질문을 던질 수 있을 것이다.\n과연 인간을 규정하고 있는 것은 무엇인가?, 인간성이란 무엇인가? \n우리는 인간 인식 능력의 두 원천 중 표상을 받아들이는 심성의 수용성, 즉 감성에 집중하였다. 칸트의 논리학에 의하면 인간의 인식 능력의 성질은 하나의 요소만으로는 불완전한 인식에 이르게 된다고 한다. 이에 인간과 달리 맹목적 본능이 결여된 기계적 입장을 플레이어로 설정하여, 인간성을 갖추기 위해 필요한 감성을 탐구하는 과정을 담은 게임을 만들어보고자 하였다.",
            "gameInstallationPathWin": "",
            "gameInstallationPathMac": "/Applications/The Humanity.app"
        },
        
        {
            "gameIndex": 1,
            "gameTitle": "The Humanity",
            "gamePlatform": "Windows, macOS",
            "gameEngine": "Unity",
            "gameGenre": "어드벤처",
            "gameDeveloper": "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
            "gamePublisher": "Bitmap Production",
            "isEarlyAccess": true,
            "gameReleasedDate": 20211210,
            "gameWebsite": "http://prodbybitmap.com/wiki/The%20Humanity",
            "gameImageURL": "http://www.prodbybitmap.com/w/images/9/99/TheHumanityPoster1.png",
            "gameHeadline": "오늘 밤, 나는 떠날 것이다",
            "gameDescription": "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발\n기술이 고도화됨에 따라 가상세계를 구축하려는 수많은 움직임이 보이고 있는 현재. SF 영화나 소설에서 볼 수 있던 사이버 세계가 더 이상 공상에서만 존재하는 것이 아닌, 현실에서 실현되고 있음을 느낄 수 있다. 그렇다면 기계와 인간의 대등한 융합이 시도되는 미래 사이버펑크 세상을 상상하며 다음과 같은 질문을 던질 수 있을 것이다.\n과연 인간을 규정하고 있는 것은 무엇인가?, 인간성이란 무엇인가? \n우리는 인간 인식 능력의 두 원천 중 표상을 받아들이는 심성의 수용성, 즉 감성에 집중하였다. 칸트의 논리학에 의하면 인간의 인식 능력의 성질은 하나의 요소만으로는 불완전한 인식에 이르게 된다고 한다. 이에 인간과 달리 맹목적 본능이 결여된 기계적 입장을 플레이어로 설정하여, 인간성을 갖추기 위해 필요한 감성을 탐구하는 과정을 담은 게임을 만들어보고자 하였다.",
            "gameInstallationPathWin": "",
            "gameInstallationPathMac": "/Applications/The Humanity.app"
        }
    ]
}
```

FetchGameInformation.swift
- Change the url that points your JSON API:
```swift
// From line 54 to 59
class gameInfoViewmodel: ObservableObject {
    // MARK: Properties
    var subscription = Set<AnyCancellable>()
    @Published var gameInfos = [gameInfo]()
    
    var url = "http://api.prodbybitmap.com/api.json"
//  ...
```
- Then modify viewmodel structure:
```swift
// From line 12 to 26
struct gameInfo: Codable {
    var gameIndex: Int
    var gameTitle: String
    var gamePlatform: String
    var gameEngine: String
    var gameGenre: String
    var gameDeveloper: String
    var gamePublisher: String
    var isEarlyAccess: Bool
    var gameReleasedDate: Int
    var gameWebsite: String
    var gameImageURL: String
    var gameHeadline: String
    var gameDescription: String
    var gameInstallationPathMac: String
//  ...
```
### Contribution
Any contribution is welcome. I only have experience in developing console applications using C/C++, and Unreal Engine Blueprints. I'm just new to Swift so I totally need community's help.

### Contact
- 이재혁 (as known as Platina): ryuplatina@icloud.com

## 한국어 설명
비트맵에 오신 것을 환영합니다! 팀원을 위한 서비스 플랫폼과 비트맵 파트너의 작품 (프로젝트 파일, 게임 등)을 무료 배포하는 ESD (Electronic Software Distribution, 전자 소프트웨어 유통)를 준비하고 있습니다.

### 시작하기
#### 필수 조건
- MacBook, Mac mini, Mac Studio, iMac, Mac Pro 등의 macOS 디바이스
- macOS Big Sur 및 이상 버전의 macOS.

##### GitHub releases에서 다운로드
GitHub [Release 페이지](https://github.com/bmplatina/BitmapMac/releases)에서 다운로드하여 설치할 수 있습니다.

##### 소스 코드에서 빌드
먼저, 아래 열거된 것들이 필요합니다:
- Xcode 13 베타 및 이상 버전
- Xcode 명령어 라인 도구
- macOS Ventura 베타 및 정식 버전 이상 버전을 구동하는 기기

그리고, 터미널을 열어 아래 명령어를 입력하세요:
```bash
cd ~/Documents/Xcode/ # 이 저장소를 클론할 위치로 이동합니다.
git clone https://github.com/bmplatina/BitmapMac/
```

셋째, Xcode를 실행해 이 프로젝트를 열고 빌드합니다.

##### Homebrew cask에서 설치
Homebrew cask를 통한 설치는 아직 지원하지 않습니다.

### API
비트맵 ESD는 서버에서 JSON 데이터르 가져옵니다. 스스로 API를 만들어 프로그램에 적욜하려면 어느 정도의 코드 수정이 필요합니다.

#### 게임
game.json
- 배열을 만들어 일정한 변수를 만듭니다:
```json
{
    "games": [
        {
            "gameIndex": 0,
            "gameTitle": "The Humanity",
            "gamePlatform": "Windows, macOS",
            "gameEngine": "Unity",
            "gameGenre": "어드벤처",
            "gameDeveloper": "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
            "gamePublisher": "Bitmap Production",
            "isEarlyAccess": true,
            "gameReleasedDate": 20211210,
            "gameWebsite": "http://prodbybitmap.com/wiki/The%20Humanity",
            "gameImageURL": "http://www.prodbybitmap.com/w/images/9/99/TheHumanityPoster1.png",
            "gameHeadline": "오늘 밤, 나는 떠날 것이다",
            "gameDescription": "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발\n기술이 고도화됨에 따라 가상세계를 구축하려는 수많은 움직임이 보이고 있는 현재. SF 영화나 소설에서 볼 수 있던 사이버 세계가 더 이상 공상에서만 존재하는 것이 아닌, 현실에서 실현되고 있음을 느낄 수 있다. 그렇다면 기계와 인간의 대등한 융합이 시도되는 미래 사이버펑크 세상을 상상하며 다음과 같은 질문을 던질 수 있을 것이다.\n과연 인간을 규정하고 있는 것은 무엇인가?, 인간성이란 무엇인가? \n우리는 인간 인식 능력의 두 원천 중 표상을 받아들이는 심성의 수용성, 즉 감성에 집중하였다. 칸트의 논리학에 의하면 인간의 인식 능력의 성질은 하나의 요소만으로는 불완전한 인식에 이르게 된다고 한다. 이에 인간과 달리 맹목적 본능이 결여된 기계적 입장을 플레이어로 설정하여, 인간성을 갖추기 위해 필요한 감성을 탐구하는 과정을 담은 게임을 만들어보고자 하였다.",
            "gameInstallationPathWin": "",
            "gameInstallationPathMac": "/Applications/The Humanity.app"
        },
        
        {
            "gameIndex": 1,
            "gameTitle": "The Humanity",
            "gamePlatform": "Windows, macOS",
            "gameEngine": "Unity",
            "gameGenre": "어드벤처",
            "gameDeveloper": "입학했더니 무한 팀플과 과제가 쌓여버린 건에 대하여",
            "gamePublisher": "Bitmap Production",
            "isEarlyAccess": true,
            "gameReleasedDate": 20211210,
            "gameWebsite": "http://prodbybitmap.com/wiki/The%20Humanity",
            "gameImageURL": "http://www.prodbybitmap.com/w/images/9/99/TheHumanityPoster1.png",
            "gameHeadline": "오늘 밤, 나는 떠날 것이다",
            "gameDescription": "서울예술대학교 인터랙티브 인스톨레이션 출품작. 김달, 이재혁, 정소연 개발\n기술이 고도화됨에 따라 가상세계를 구축하려는 수많은 움직임이 보이고 있는 현재. SF 영화나 소설에서 볼 수 있던 사이버 세계가 더 이상 공상에서만 존재하는 것이 아닌, 현실에서 실현되고 있음을 느낄 수 있다. 그렇다면 기계와 인간의 대등한 융합이 시도되는 미래 사이버펑크 세상을 상상하며 다음과 같은 질문을 던질 수 있을 것이다.\n과연 인간을 규정하고 있는 것은 무엇인가?, 인간성이란 무엇인가? \n우리는 인간 인식 능력의 두 원천 중 표상을 받아들이는 심성의 수용성, 즉 감성에 집중하였다. 칸트의 논리학에 의하면 인간의 인식 능력의 성질은 하나의 요소만으로는 불완전한 인식에 이르게 된다고 한다. 이에 인간과 달리 맹목적 본능이 결여된 기계적 입장을 플레이어로 설정하여, 인간성을 갖추기 위해 필요한 감성을 탐구하는 과정을 담은 게임을 만들어보고자 하였다.",
            "gameInstallationPathWin": "",
            "gameInstallationPathMac": "/Applications/The Humanity.app"
        }
    ]
}
```

FetchGameInformation.swift
- 자신의 JSON API URL로 변경합니다:
```swift
// From line 54 to 59
class gameInfoViewmodel: ObservableObject {
    // MARK: Properties
    var subscription = Set<AnyCancellable>()
    @Published var gameInfos = [gameInfo]()
    
    var url = "http://api.prodbybitmap.com/api.json"
//  ...
```
- 그리고 API에 맞게 뷰모델 구조체를 수정합니다:
```swift
// From line 12 to 26
struct gameInfo: Codable {
    var gameIndex: Int
    var gameTitle: String
    var gamePlatform: String
    var gameEngine: String
    var gameGenre: String
    var gameDeveloper: String
    var gamePublisher: String
    var isEarlyAccess: Bool
    var gameReleasedDate: Int
    var gameWebsite: String
    var gameImageURL: String
    var gameHeadline: String
    var gameDescription: String
    var gameInstallationPathMac: String
//  ...
```

### 기여
어떤 기여도 감사히 받아들이겠습니다. C/C++를 활용한 콘솔 애플리케이션과 언리얼 엔진 블루프린트 등의 코딩 경험은 있으나 Swift 개발은 처음이므로 커뮤니티의 도움이 절실합니다.

### 연락처
- 이재혁 (Platina): ryuplatina@icloud.com

## Package Dependncies: 패키지 의존성
- Alamofire
- Files
- SwiftyJSON
- URLImgae
- YouTubePlayerKit
- ZIPFoundation

## Got Help
- https://stackoverflow.com/questions/73123581/swiftui-how-to-parse-json-arrays-from-url-using-alamofire
- https://www.youtube.com/c/%EA%B0%9C%EB%B0%9C%ED%95%98%EB%8A%94%EC%A0%95%EB%8C%80%EB%A6%AC
