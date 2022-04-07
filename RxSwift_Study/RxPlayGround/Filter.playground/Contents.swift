import UIKit
import RxSwift

let disposeBag = DisposeBag()

print("--skip--")
Observable.of("1","2","3","4","5")
    .skip(4)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)




print("--skipWhile--")
Observable.of("1","2","3","4","5","6","7","8")
    .skip(while: {
        $0 != "4"
    })
    .subscribe(onNext: {
        print($0)
    })
.disposed(by: disposeBag)


print("--skipUntil--")
let customer = PublishSubject<String>()
let openDoor = PublishSubject<String>()



customer
    .skip(until: openDoor)
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

customer.onNext("1")
customer.onNext("2")

openDoor.onNext("open!!")

customer.onNext("3")

print("--take--")
Observable<String>.of("11","22","333","444","5","6")
    .take(3)
    .subscribe(onNext: {
        print($0)
    })
.disposed(by: disposeBag)


print("--takeWhile--")
Observable.of("a","b","c","d","e")
    .take(while: {
        $0 != "c"
    })
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

print("--enumrated--")
Observable.of("a","b","c","d","e")
    .enumerated()
    .takeWhile {
        $0.index < 3
    }
    .subscribe(onNext: {
        print($0)
    })
    .disposed(by: disposeBag)

