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
### 스토리보드 관리
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
### 네비게이션 백버튼
* Master View Controller에서 Edit->Embeded in->Navigation Controller 선택하면 백버튼 자동으로 생김

## 2016.07.16
### 네트워크 권한 설정
* swift에서 네트워크를 사용하려면 info.plist를 수정해야한다.
* Bundle OS Type Code 마우스 우클릭 -> Add Rows -> App Transport Security Settings -> + -> Allow Arbitary Loads -> YES

#2016.07.18
### 옵셔널
* xcode에서 외부 파일을 추가하기 위해서는 추가 할 위치의 폴더 마우스 우클릭 후 Add File to "Project Name" -> 추가할 파일 or 폴더로 이동 후 하단의 옵션 클릭 -> Folders 에서 위에꺼 선택
* ? = Optional 
	* nil을 가질 수 있는 변수를 특별히 관리하기 위함
	* Java의 NullPointerException을 방지
* ! = Force Unwrapping
	* 값의 존재를 확신할 때
	* 하지만 그 사용을 지양해야함 Optional을 무력화 시키기 때문이다.
	* !를 많이 쓸 수록 안좋은 코드(위험 요소가 많은 코드이다.)
	* if let을 많이 써라!
* Implicitly Unwrapped Optional
	* 선언 시 !을 사용
	* 최초에 값을 부여할 수 없어 어쩔 수 없이 초기 값이 nil이지만 이 값은 프로그래밍 동작 시에 무조건 값을 가질 때 사용한다.
	* 대부분의 API 는 CoCoa 즉 Objective C로 구현되어 있기에 Swift와의 호환을 위해 Implicitly Unwrapped Optional 을 사용한다.
	
# 2016.07.19
### String nil 체크
* optional 상태에서 isEmpty를 부르면 안된다.
* String에서 isEmpty함수를 호출하면 비었는지 확인해준다.

## 2016.07.22
### nil 체크
그냥 if let을 쓰면 되는 줄 알았지만 NSNull의 형태도 있으므로 if let 이후에 !(object is NSNULL)로 한 번 더 체크한다

### Alert 띄우는 법 
~~~~
let alert = UIAlertController(title: "타이틀", message: "메세지", preferredStyle: UIAlertController.Alert)
alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
self.presentViewController(alert, animated: true, completion: nil)
~~~~

### JSON 
####Dicionary to JSON
~~~~
do {
	let data = ["id": "아이디", "pw": "비밀번호"]
	let dataStr = try NSJSONSerialization.dataWithJSONObject(data, option: .PrettyPrinted)
	let dataJson = try NSJSONSerialization.JSONObjectWithData(dataStr, options: [])
} catch let error as NSError {
	print(error)
}
~~~~

#### JSON Parse
`let value = json["key"]` 의 형태로 값을 받아온다.

### Move Segue Programmatically
#### 방금 전 뷰컨트롤러로 이동
`navigationController?.popViewControllerAnimated(true)`

#### 특정 뷰 컨트롤러로 이동
`performSegueWithIdentifier(identifier: "loginSuccess", sender: self)`  
identifier는 StoryBoard에서 FromViewController 선택 후 최상단의 ViewController 컨트롤 클릭 후 ToViewController로 끌어놓는다. 그리고 Segue에 id를 부여한다.


### ViewController Comflict 에러
~~~~
<inferredMetricsTieBreakers>
    <segue reference="W66-pd-E0y"/>
</inferredMetricsTieBreakers>
~~~~