# OneDayiOS

## Development Environment

###Client
Language : Swift
Version : 2.2

###Server
Language : 파이썬
Framework : 플라스크
Flask Version : ?

## 개발 규칙
1. 개발해야 할 내용들을 이슈 등록 해둔다.
2. 이슈들 중 자신이 지금 하는 내용은 자신에게 할당(assign) 한다.
3. master에 푸시하지 않는다.
4. 풀 리퀘(pull request)방식으로 개발한다.

##Update Log
* 회원가입
* 로그인

# 배운점
## 2016.07.11
* 스토리보드에서 뷰에 커서를 두고 컨트롤을 누른 뒤 옆 뷰로 드롭하면 Equal Width 옵션을 줄 수 있다.
* 스토리보드에서 뷰에 커서를 두고 컨트롤을 누른 뒤 다른 스토리보드로 드롭하면 Segue를 설정할 수 있다.
* Action Segue Type
	* Show  
	네비게이션 스택 위로 원하는 뷰 컨트롤러로 푸시한다. 기존 뷰 컨트롤러는 방해가 되지 않게 비킨다. (목적 뷰 컨트롤러가 우측에서 좌측으로 나타난다.) 모든 디바이스에서 백 버튼이 이전 화면으로 돌아가기 위해 제공된다.
	* Show Detail  
	    이전의 뷰 컨트롤러로 돌아갈 수 없는 UISplitViewController    안에 있을 때    detail/secondary     뷰 컨트롤러를 제거한다. 
	* Present Modally  
	프레젠테이션 속성으로 정하고, 이전 뷰 컨트롤러를 덮음으로써 다양한 방법으로 뷰 컨트롤러를 보여 준다. 뷰 컨트롤러를 보여주기 위해 아이폰에서 가장 자주 쓰이는 방법은 아래에서부터 덮이는 방법과 화면 전체를 덮는 방법이다. 하지만 아이패드에서는 보통 중앙에서 어두운 뷰 컨트롤러 박스가 올라오고, 또한 아래에서부터 애니메이션이 시작된다.
	* Popover Presentation  
	아이패드에서는 조그만 팝오버로 도착지가 나타나고 이 팝오버 밖 아무데나 탭하면 팝오버는 사라진다. 아이폰에서는 팝오버도 잘 지원된다. 하지만 기본값에 의하면 만약 그것이 팝오버 프레젠테이션 시그로 실행된다면, 그것은 풀스크린 형식으로 목적 뷰 컨트롤러에 보여질것이다.
	When run on iPad, the destination appears in a small popover, and tapping anywhere outside of this popover will dismiss it. On iPhone, popovers are supported as well but by default if it performs a Popover Presentation segue, it will present the destination view controller modally over the full screen.
	
	Reference : <http://stackoverflow.com/questions/25966215/whats-the-difference-between-all-the-selection-segues>
	
## 2016.07.12
* Master View Controller에서 Edit->Embeded in->Navigation Controller 선택하면 백버튼 자동으로 생김

## 2016.07.16
* swift에서 네트워크를 사용하려면 info.plist를 수정해야한다.
* Bundle OS Type Code 마우스 우클릭 -> Add Rows -> App Transport Security Settings -> + -> Allow Arbitary Loads -> YES

#2016.07.18
* xcode에서 외부 파일을 추가하기 위해서는 추가 할 위치의 폴더 마우스 우클릭 후 Add File to "Project Name" -> 추가할 파일 or 폴더로 이동 후 하단의 옵션 클릭 -> Folders 에서 위에꺼 선택