import RxSwift

let disposBag = DisposeBag()

print("--toArray--")
Observable.of("A","B","C")
    .toArray()
    .subscribe(onSuccess: {
        print($0)
    })
    .disposed(by: disposBag)

print("--map--")
Observable.of(Date())
    .map { date -> String in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy--MM--dd"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        
        return dateFormatter.string(from: date)
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

print("--flatMap--")
protocol player {
    var score: BehaviorSubject<Int> { get }
}

struct archer: player {
    var score: BehaviorSubject<Int>
}

let koreaNationalAthlete = archer(score: BehaviorSubject<Int>(value: 2))
let americaNationalAthlete = archer(score: BehaviorSubject<Int>(value: 1))

let olympicGame = PublishSubject<player>()

olympicGame
    .flatMap { player in
        player.score
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposBag)

olympicGame.onNext(koreaNationalAthlete)
koreaNationalAthlete.score.onNext(10)

olympicGame.onNext(americaNationalAthlete)
koreaNationalAthlete.score.onNext(10)
americaNationalAthlete.score.onNext(9)

print("--flatMapLatest--")
struct highJumper: player {
    var score: BehaviorSubject<Int>
}

let seoul = highJumper(score: BehaviorSubject<Int>(value: 7))
let jeju = highJumper(score: BehaviorSubject<Int>(value: 6))
let nationalChampionship = PublishSubject<player>()
                      
    nationalChampionship
    .flatMapLatest { player in
        player.score
    }
    .subscribe(onNext: {
        print($0)
    })
        .disposed(by: disposBag)
                      
                      nationalChampionship.onNext(seoul)
                      seoul.score.onNext(9)
                      
                      nationalChampionship.onNext(jeju)
                      seoul.score.onNext(10)
                      jeju.score.onNext(8)
                      
                      
                      
