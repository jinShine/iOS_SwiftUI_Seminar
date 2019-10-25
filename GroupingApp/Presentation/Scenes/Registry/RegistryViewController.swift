//
//  RegistryViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import JVFloatLabeledTextField

class RegistryViewController: BaseViewController, ViewType {

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

  let profileBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "Navi_Base_Long")
    view.contentMode = .scaleToFill
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
    button.setImage(UIImage(named: "AddPhoto"), for: .normal)
    return button
  }()

  let essentialInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "필수 정보"
    label.font = App.font.bold(size: 18)
    return label
  }()

  let nameTextField = SJTextField(placeholder: "이름 *")
  let numberTextField = SJTextField(placeholder: "전화번호 *")
  let crewTextField = SJTextField(placeholder: "ex) 동아리명/기수 *")

  let additionalInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "추가 정보"
    label.font = App.font.bold(size: 18)
    return label
  }()

  let addressField = SJTextField(placeholder: "주소")
  let emailTextField = SJTextField(placeholder: "이메일")
  let birthTextField = SJTextField(placeholder: "생일")
  let memoTextView: JVFloatLabeledTextView = {
    let textView = JVFloatLabeledTextView()
    textView.placeholder = "메모"
    textView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    textView.floatingLabelYPadding = 12
    textView.layer.cornerRadius = 16
    textView.layer.masksToBounds = true
    textView.clipsToBounds = false
    textView.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: 2, blur: 10)
    return textView
  }()

  let dismissButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon_Arrow_Down"), for: .normal)
    button.imageView?.tintColor = .white
    button.contentMode = .scaleAspectFit
    return button
  }()

  let naviTitleLabel: UILabel = {
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
    button.unActivate()
    return button
  }()

  //MARK: - Properties
  var viewModel: RegistryViewModel!
  var disposeBag: DisposeBag!


  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  //MARK: - Setup UI
  func setupUI() {

    [baseScrollView].forEach {
      view.addSubview($0)
    }

    [baseContentView].forEach {
      baseScrollView.addSubview($0)
    }

    [profileBaseView, profileButton, addProfileButton, essentialInfoLabel,
     additionalInfoLabel, nameTextField, numberTextField, crewTextField,
     addressField, emailTextField, birthTextField, memoTextView].forEach {
      baseContentView.addSubview($0)
    }

    setupNavigationBar(at: view, leftItem: dismissButton, titleItem: naviTitleLabel, rightItem: saveButton)

  }

  //MARK: - Setup Constraints
  func setupConstraints() {
    baseScrollView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    baseContentView.snp.makeConstraints {
      $0.edges.equalToSuperview()
      $0.width.equalToSuperview()
      $0.height.equalToSuperview().priority(250)
    }

    profileBaseView.snp.makeConstraints {
      $0.top.equalToSuperview().offset(-50)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(300)
    }

    profileButton.snp.makeConstraints {
      $0.centerX.equalTo(profileBaseView)
      $0.centerY.equalTo(profileBaseView).offset(50)
      $0.width.height.equalTo(120)
      profileButton.layer.cornerRadius = 120 / 2
      profileButton.layer.masksToBounds = true
    }

    addProfileButton.snp.makeConstraints {
      $0.centerX.equalTo(profileBaseView)
      $0.top.equalTo(profileButton.snp.bottom).offset(14)
    }

    essentialInfoLabel.snp.makeConstraints {
      $0.top.equalTo(profileBaseView.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }

    nameTextField.snp.makeConstraints {
      $0.top.equalTo(essentialInfoLabel.snp.bottom).offset(16)
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

    additionalInfoLabel.snp.makeConstraints {
      $0.top.equalTo(crewTextField.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(46)
    }

    addressField.snp.makeConstraints {
      $0.top.equalTo(additionalInfoLabel.snp.bottom).offset(16)
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

    memoTextView.snp.makeConstraints {
      $0.top.equalTo(birthTextField.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(300)
      $0.bottom.equalTo(baseContentView).offset(-32)
    }
  }

  //MARK: - Bind
  func bindViewModel() {

    //INPUT
    let didTapDismiss = dismissButton.rx.tap.asDriver()
    let keyboarWillShow = NotificationCenter.default.rx.notification(UIApplication.keyboardWillShowNotification)
    let keyboarWillHide = NotificationCenter.default.rx.notification(UIApplication.keyboardWillHideNotification)
    let didTapAddPhoto = Driver.of(profileButton.rx.tap.asDriver(), addProfileButton.rx.tap.asDriver()).merge()

    let input = RegistryViewModel.Input(didTapDismiss: didTapDismiss,
                                        keyboardWillShowTrigger: keyboarWillShow,
                                        keyboardWillHideTrigger: keyboarWillHide,
                                        didTapAddPhoto: didTapAddPhoto)


    //OUTPUT
    let output = viewModel.transform(input: input)

    output.dismiss
      .drive()
      .disposed(by: disposeBag)

    output.keyboardHeight
      .drive(onNext: { height in
        self.baseScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
      })
    .disposed(by: disposeBag)

    output.keyboardDidHide
    .drive(onNext: { _ in
      self.baseScrollView.contentInset = UIEdgeInsets.zero
      UIView.animate(withDuration: 0.25) {
        self.view.layoutIfNeeded()
      }
    })
    .disposed(by: disposeBag)

    output.pickerController
      .drive(onNext: { pickerVC in
        pickerVC.delegate = self
        self.present(pickerVC, animated: true, completion: nil)
      })
    .disposed(by: disposeBag)

  }
}

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

//import RxSwift
//import RxCocoa
//import JVFloatLabeledTextField
//
//class RegistryViewController: BaseViewController, BindViewType {
//
//  //MARK: - Constant
//  struct Constant {
//
//  }
//
//
//  //MARK: - UI Properties
//
//  let baseScrollView: UIScrollView = {
//    let scrollview = UIScrollView()
//    scrollview.bounces = false
//    scrollview.keyboardDismissMode = .interactive
//    return scrollview
//  }()
//
//  let baseContentView: UIView = {
//    let view = UIView()
//    return view
//  }()
//
//  let profileBaseView: UIImageView = {
//    let view = UIImageView()
//    view.image = UIImage(named: "Navi_Base_Long")
//    view.contentMode = .scaleToFill
//    return view
//  }()
//
//  let profileButton: UIButton = {
//    let button = UIButton()
//    button.setBackgroundImage(UIImage(named: "Empty_Profile"), for: .normal)
//    button.contentMode = .scaleToFill
//    return button
//  }()
//
//  let addProfileButton: UIButton = {
//    let button = UIButton()
//    button.setImage(UIImage(named: "AddPhoto"), for: .normal)
//    return button
//  }()
//
//  let essentialInfoLabel: UILabel = {
//    let label = UILabel()
//    label.text = "필수 정보"
//    label.font = App.font.bold(size: 18)
//    return label
//  }()
//
//  let nameTextField = SJTextField(placeholder: "이름 *")
//  let numberTextField = SJTextField(placeholder: "전화번호 *")
//  let crewTextField = SJTextField(placeholder: "ex) 동아리명/기수 *")
//
//  let additionalInfoLabel: UILabel = {
//    let label = UILabel()
//    label.text = "추가 정보"
//    label.font = App.font.bold(size: 18)
//    return label
//  }()
//
//  let addressField = SJTextField(placeholder: "주소")
//  let emailTextField = SJTextField(placeholder: "이메일")
//  let birthTextField = SJTextField(placeholder: "생일")
//  let memoTextView: JVFloatLabeledTextView = {
//    let textView = JVFloatLabeledTextView()
//    textView.placeholder = "메모"
//    textView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
//    textView.floatingLabelYPadding = 12
//    textView.layer.cornerRadius = 16
//    textView.layer.masksToBounds = true
//    textView.clipsToBounds = false
//    textView.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: 2, blur: 10)
//    return textView
//  }()
//
//  let dismissButton: UIButton = {
//    let button = UIButton()
//    button.setImage(UIImage(named: "Icon_Arrow_Down"), for: .normal)
//    button.imageView?.tintColor = .white
//    button.contentMode = .scaleAspectFit
//    return button
//  }()
//
//  let naviTitleLabel: UILabel = {
//    let label = UILabel()
//    label.text = "새로운 연락처"
//    label.textColor = .white
//    label.font = App.font.bold(size: 18)
//    label.textAlignment = .center
//    return label
//  }()
//
//  let saveButton: UIButton = {
//    let button = UIButton()
//    button.setTitle("저장", for: .normal)
//    button.titleLabel?.contentMode = .center
//    button.titleLabel?.font = App.font.regular(size: 16)
//    button.unActivate()
//    return button
//  }()
//
//
//  //MARK: - Properties
//  typealias ViewModel = RegistryViewModel
//  var disposeBag = DisposeBag()
//  var navigator: RegistryNavigator?
//
//
//  init(viewModel: ViewModel) {
//    defer {
//      self.viewModel = viewModel
//    }
//
//    super.init()
//  }
//
//  required init?(coder aDecoder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//
//  deinit {
//    NotificationCenter.default.removeObserver(self)
//  }
//
//  //MARK: - Life Cycle
//  override func viewDidLoad() {
//    super.viewDidLoad()
//
//    setupUI()
//    setupConstraint()
//    setupNavigator()
//
//    addDismissTabGesture(in: baseScrollView)
//
//    baseScrollView.delegate = self
//    addressField.delegate = self
//  }
//
//}
//
////MARK: - Bind
//extension RegistryViewController {
//
//  //INPUT
//  func command(viewModel: ViewModel) {
//
//    let obDidTapDismiss = dismissButton.rx.tap
//      .map { ViewModel.Command.dismiss }
//
//    let obKeyboardWillShow = NotificationCenter.default.rx
//      .notification(UIApplication.keyboardWillShowNotification)
//      .map {
//        ViewModel.Command.keyboardWillShow($0)
//    }
//
//    let obKeyboardWillHide = NotificationCenter.default.rx
//      .notification(UIApplication.keyboardWillHideNotification)
//      .map { _ in ViewModel.Command.keyboardWillHide }
//
//    let obProfileButton = profileButton.rx.tap.asObservable()
//    let obAddProfileButton = addProfileButton.rx.tap.asObservable()
//    let obDidTapAddPhoto = Observable.merge([obProfileButton, obAddProfileButton])
//      .map { ViewModel.Command.didTapAddPhto }
//
//
//    let obUserInfoCombine = Observable.combineLatest(nameTextField.rx.text,
//                                                      numberTextField.rx.text,
//                                                      crewTextField.rx.text,
//                                                      addressField.rx.text,
//                                                      emailTextField.rx.text,
//                                                      birthTextField.rx.text)
//
//    let userInfoValidation = obUserInfoCombine
//      .map { UserModel(name: $0.0!, number: $0.1!, crew: $0.2!, address: $0.3, email: $0.4, birth: $0.5) }
//      .map { ViewModel.Command.userValidation(user: $0) }
//
//    let obDidTapSaveButton = saveButton.rx.tap.asObservable()
//      .withLatestFrom(obUserInfoCombine)
//      .map { UserModel(name: $0.0!, number: $0.1!, crew: $0.2!, address: $0.3, email: $0.4, birth: $0.5) }
//      .map { ViewModel.Command.didTapSave(user: $0)}
//
//
//    Observable<ViewModel.Command>.merge([
//      obDidTapDismiss,
//      obKeyboardWillShow,
//      obKeyboardWillHide,
//      obDidTapAddPhoto,
//      userInfoValidation,
//      obDidTapSaveButton
//    ])
//    .bind(to: viewModel.command)
//    .disposed(by: disposeBag)
//
//  }
//
//
//  //OUTPUT
//  func state(viewModel: ViewModel) {
//
//    viewModel.state
//      .drive(onNext: { [weak self] state in
//        guard let self = self else { return }
//
//        switch state {
//        case .dismissState:
//          self.dismiss(animated: true, completion: nil)
//
//        case .keyboardWillShowState(let keyboardHeight):
//          self.baseScrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
//
//        case .keyboardWillHideState:
//          self.baseScrollView.contentInset = UIEdgeInsets.zero
//          UIView.animate(withDuration: 0.25) {
//            self.view.layoutIfNeeded()
//          }
//
//        case .didTapAddPhtoState:
//          guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else { return }
//          let pickerContoller = UIImagePickerController()
//          pickerContoller.delegate = self
//          self.present(pickerContoller, animated: true, completion: nil)
//
//        case .userValidationState(let result):
//          result ? self.saveButton.activate() : self.saveButton.unActivate()
//
//        case .didTapSaveState:
//          self.dismiss(animated: true) {
//          }
//        }
//      })
//      .disposed(by: self.disposeBag)
//  }
//
//}
//
////MARK: - Method Handler
//extension RegistryViewController {
//
//  private func setupUI() {
//    navigationController?.isNavigationBarHidden = true
//
//    [baseScrollView].forEach { view.addSubview($0) }
//    [baseContentView].forEach { baseScrollView.addSubview($0) }
//    [profileBaseView, profileButton, addProfileButton,
//     essentialInfoLabel, additionalInfoLabel, nameTextField, numberTextField, crewTextField,
//      addressField, emailTextField, birthTextField, memoTextView].forEach {
//      baseContentView.addSubview($0)
//    }
//
//    setupNavigationBar(at: view, leftItem: dismissButton, titleItem: naviTitleLabel, rightItem: saveButton)
//  }
//
//  private func setupConstraint() {
//
//    baseScrollView.snp.makeConstraints {
//      $0.edges.equalToSuperview()
//    }
//
//    baseContentView.snp.makeConstraints {
//      $0.edges.equalToSuperview()
//      $0.width.equalToSuperview()
//      $0.height.equalToSuperview().priority(250)
//    }
//
//    profileBaseView.snp.makeConstraints {
//      $0.top.equalToSuperview().offset(-50)
//      $0.leading.trailing.equalToSuperview()
//      $0.height.equalTo(300)
//    }
//
//    profileButton.snp.makeConstraints {
//      $0.centerX.equalTo(profileBaseView)
//      $0.centerY.equalTo(profileBaseView).offset(50)
//      $0.width.height.equalTo(120)
//      profileButton.layer.cornerRadius = 120 / 2
//      profileButton.layer.masksToBounds = true
//    }
//
//    addProfileButton.snp.makeConstraints {
//      $0.centerX.equalTo(profileBaseView)
//      $0.top.equalTo(profileButton.snp.bottom).offset(14)
//    }
//
//    essentialInfoLabel.snp.makeConstraints {
//      $0.top.equalTo(profileBaseView.snp.bottom).offset(32)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    nameTextField.snp.makeConstraints {
//      $0.top.equalTo(essentialInfoLabel.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    numberTextField.snp.makeConstraints {
//      $0.top.equalTo(nameTextField.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    crewTextField.snp.makeConstraints {
//      $0.top.equalTo(numberTextField.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    additionalInfoLabel.snp.makeConstraints {
//      $0.top.equalTo(crewTextField.snp.bottom).offset(32)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    addressField.snp.makeConstraints {
//      $0.top.equalTo(additionalInfoLabel.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    emailTextField.snp.makeConstraints {
//      $0.top.equalTo(addressField.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    birthTextField.snp.makeConstraints {
//      $0.top.equalTo(emailTextField.snp.bottom).offset(16)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(46)
//    }
//
//    memoTextView.snp.makeConstraints {
//      $0.top.equalTo(birthTextField.snp.bottom).offset(32)
//      $0.leading.equalToSuperview().offset(16)
//      $0.trailing.equalToSuperview().offset(-16)
//      $0.height.equalTo(300)
//      $0.bottom.equalTo(baseContentView).offset(-32)
//    }
//
//  }
//
//  private func setupNavigator() {
//    navigator = RegistryNavigator(with: self.navigationController)
//  }
//
//}
//
////MARK: - UIPickerController Delegate
//extension RegistryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//    let originImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//    self.profileButton.setImage(originImage, for: .normal)
//    self.dismiss(animated: true, completion: nil)
//
//  }
//
//  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//    self.dismiss(animated: true, completion: nil)
//  }
//
//}
//
////MARK: - UIScrollViewDelegate
//extension RegistryViewController: UIScrollViewDelegate {
//
//  func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//    if scrollView.contentOffset.y >= 190 {
//      self.naviTitleLabel.textColor = .black
//      self.dismissButton.imageView?.tintColor = .black
//      self.saveButton.titleLabel?.textColor = .black
//    } else {
//      self.naviTitleLabel.textColor = .white
//      self.dismissButton.imageView?.tintColor = .white
//      self.saveButton.titleLabel?.textColor = .white
//    }
//
//  }
//}
//
////MARK: - UITextFieldDelegate
//extension RegistryViewController: UITextFieldDelegate {
//
//  func textFieldDidBeginEditing(_ textField: UITextField) {
//    dismissKeyboard()
//    App.loading.show()
//    navigator?.navigate(to: .addressSearch)
//  }
//
//}
