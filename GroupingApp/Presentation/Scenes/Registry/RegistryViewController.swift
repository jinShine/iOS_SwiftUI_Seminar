//
//  RegistryViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import TextFieldEffects

class RegistryViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {

  }


  //MARK: - UI Properties
  let baseScrollView: UIScrollView = {
    let scrollview = UIScrollView()
    scrollview.bounces = false
    scrollview.keyboardDismissMode = .interactive
    return scrollview
  }()
  
  let baseContentView: UIView = {
    let view = UIView()
    return view
  }()
  
  let naviBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "Navi_Base_Long")
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  let profileButton: UIButton = {
    let button = UIButton()
    button.setBackgroundImage(UIImage(named: "Empty_Profile"), for: .normal)
    button.contentMode = .scaleToFill
    return button
  }()
  
  let addProfileButton: UIButton = {
    let button = UIButton()
    button.setTitle("사진 추가", for: .normal)
    button.titleLabel?.font = App.font.regular(size: 14)
    return button
  }()

  let nameTextField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "이름 *"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let numberTextField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "전화번호 *"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let crewTextField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "동아리명/기수 *"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let addressField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "주소"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let emailTextField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "이메일"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let birthTextField: HoshiTextField = {
    let textField = HoshiTextField()
    textField.placeholder = "생일"
    textField.placeholderColor = App.color.line
    
    let line = UIView()
    line.backgroundColor = App.color.line
    textField.addSubview(line)
    line.snp.makeConstraints {
      $0.top.equalTo(textField.snp.bottom).offset(10)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(1)
    }
    
    return textField
  }()
  
  let dismissButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon_Arrow_Down"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "새로운 연락처"
    label.textColor = .white
    label.font = App.font.bold(size: 18)
    label.textAlignment = .center
    return label
  }()
  
  let saveButton: UIButton = {
    let button = UIButton()
    button.setTitle("저장", for: .normal)
    button.titleLabel?.contentMode = .center
    button.titleLabel?.font = App.font.regular(size: 16)
    return button
  }()
  
//  let memoTextField: HoshiTextField = {
//    let textField = HoshiTextField()
//    textField.placeholder = "메모"
//    textField.placeholderColor = App.color.line
//
//    let line = UIView()
//    line.backgroundColor = App.color.line
//    textField.addSubview(line)
//    line.snp.makeConstraints {
//      $0.top.equalTo(textField.snp.bottom).offset(10)
//      $0.leading.trailing.equalToSuperview()
//      $0.height.equalTo(1)
//    }
//
//    return textField
//  }()
  





  //MARK: - Properties
  typealias ViewModel = RegistryViewModel
  var disposeBag = DisposeBag()


  init(viewModel: ViewModel) {
    defer {
      self.viewModel = viewModel
    }
    super.init()

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupConstraint()

    addDismissTabGesture(view: baseScrollView)
    
    
  }

  
}

//MARK: - Bind
extension RegistryViewController {

  //OUTPUT
  func command(viewModel: ViewModel) {
    
    let obDismiss = dismissButton.rx.tap
      .map { ViewModel.Command.dismiss }

    let obKeyboardWillShow = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillShowNotification)
      .map {
        ViewModel.Command.keyboardWillShow($0)
    }
    
    let obKeyboardWillHide = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillHideNotification)
      .map { _ in ViewModel.Command.keyboardWillHide }
    
    let obProfileButton = profileButton.rx.tap.asObservable()
    let obAddProfileButton = addProfileButton.rx.tap.asObservable()
    let obAddPhoto = Observable.merge([obProfileButton, obAddProfileButton])
      .map { ViewModel.Command.didTapAddPhto }
    
    
    let obUserInfoCombine = Observable.combineLatest([nameTextField.rx.text,
                                                      numberTextField.rx.text,
                                                      crewTextField.rx.text,
                                                      addressField.rx.text,
                                                      emailTextField.rx.text,
                                                      birthTextField.rx.text])

    let obSaveButton = saveButton.rx.tap
      .withLatestFrom(obUserInfoCombine)
      .map { userInfo in
        userInfo
        ViewModel.Command.didTapSave(user: userInfo)
    }
    
    
    Observable<ViewModel.Command>.merge([
      obDismiss,
      obKeyboardWillShow,
      obKeyboardWillHide,
      obAddPhoto,
      obSaveButton
    ])
    .bind(to: viewModel.command)
    .disposed(by: disposeBag)
    
  }


  //INPUT
  func state(viewModel: ViewModel) {

    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }

        switch state {
        case .dismissState:
          self.dismiss(animated: true, completion: nil)
        case .keyboardWillShowState(let keyboardHeight):
          self.baseScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        case .keyboardWillHideState:
          self.baseScrollView.contentInset = UIEdgeInsets.zero
          UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
          }
        case .didTapAddPhtoState:
          guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
          let pickerContoller = UIImagePickerController()
          pickerContoller.delegate = self
          self.present(pickerContoller, animated: true, completion: nil)
          
        case .didTapSaveState:
          print("asdf")
        }

      })
      .disposed(by: self.disposeBag)
  }

}

//MARK: - Method Handler
extension RegistryViewController {

  private func setupUI() {
    navigationController?.isNavigationBarHidden = true
    
    [baseScrollView].forEach { view.addSubview($0) }
    [baseContentView].forEach { baseScrollView.addSubview($0) }
    [naviBaseView, profileButton, addProfileButton,
     nameTextField, numberTextField, crewTextField,
      addressField, emailTextField, birthTextField].forEach {
      baseContentView.addSubview($0)
    }

    setupNavigationBar(at: baseContentView, leftItem: dismissButton, titleItem: titleLabel, rightItem: saveButton)
    
  }

  private func setupConstraint() {
    
    baseScrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    
    baseContentView.snp.makeConstraints {
      $0.top.bottom.equalTo(baseScrollView)
      $0.leading.trailing.equalTo(view)
      $0.width.height.equalTo(baseScrollView)
    }

    naviBaseView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(300)
    }
    
    profileButton.snp.makeConstraints {
      $0.centerX.equalTo(naviBaseView)
      $0.centerY.equalTo(naviBaseView).offset(50)
      $0.width.height.equalTo(120)
      profileButton.layer.cornerRadius = 120 / 2
      profileButton.layer.masksToBounds = true
    }
    
    addProfileButton.snp.makeConstraints {
      $0.centerX.equalTo(naviBaseView)
      $0.top.equalTo(profileButton.snp.bottom).offset(10)
    }
    
    nameTextField.snp.makeConstraints {
      $0.top.equalTo(naviBaseView.snp.bottom).offset(100)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
    numberTextField.snp.makeConstraints {
      $0.top.equalTo(nameTextField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
    crewTextField.snp.makeConstraints {
      $0.top.equalTo(numberTextField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
    addressField.snp.makeConstraints {
      $0.top.equalTo(crewTextField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
    emailTextField.snp.makeConstraints {
      $0.top.equalTo(addressField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
    birthTextField.snp.makeConstraints {
      $0.top.equalTo(emailTextField.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }
    
  }

}

//MARK: - UIPickerController Delegate
extension RegistryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

    let originImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    self.profileButton.setImage(originImage, for: .normal)
    self.dismiss(animated: true, completion: nil)

  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }

}
