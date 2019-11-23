//
//  RegistryViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import NSObject_Rx
import JVFloatLabeledTextField

class RegistryViewController: BaseViewController, ViewType {
  
  //MARK: - Constant
  struct Constant {}
  
  //MARK: - UI Properties
  
  let rootScrollView: UIScrollView = {
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
    button.contentMode = .scaleAspectFit
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

  let nameTextField: SJTextField = {
    let textField = SJTextField(placeholder: "이름 *")
    return textField
  }()

  let numberTextField: SJTextField = {
    let textField = SJTextField(placeholder: "전화번호 *")
    return textField
  }()

  let crewTextField: SJTextField = {
    let textField = SJTextField(placeholder: "ex) 동아리명/기수 *")
    return textField
  }()
  
  let additionalInfoLabel: UILabel = {
    let label = UILabel()
    label.text = "추가 정보"
    label.font = App.font.bold(size: 18)
    return label
  }()

  let addressField: SJTextField = {
    let textField = SJTextField(placeholder: "주소")
    return textField
  }()

  let emailTextField: SJTextField = {
    let textField = SJTextField(placeholder: "이메일")
    return textField
  }()

  let birthTextField: SJTextField = {
    let textField = SJTextField(placeholder: "생일")
    return textField
  }()

  let memoTextView: JVFloatLabeledTextView = {
    let textView = JVFloatLabeledTextView()
    textView.placeholder = "메모"
    textView.floatingLabelYPadding = 12
    textView.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    textView.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: 2, blur: 10)
    textView.layer.cornerRadius = 16
    textView.layer.masksToBounds = true
    textView.clipsToBounds = false
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
    button.inActivate()
    return button
  }()
  
  //MARK: - Properties
  var viewModel: RegistryViewModel!
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  //MARK: - Setup UI
  func setupUI() {
    
    [rootScrollView].forEach {
      view.addSubview($0)
    }
    
    [baseContentView].forEach {
      rootScrollView.addSubview($0)
    }
    
    [profileBaseView, profileButton, addProfileButton, essentialInfoLabel,
     additionalInfoLabel, nameTextField, numberTextField, crewTextField,
     addressField, emailTextField, birthTextField, memoTextView].forEach {
      baseContentView.addSubview($0)
    }
    
    setupNavigationBar(at: view, leftItem: dismissButton, titleItem: naviTitleLabel, rightItem: saveButton)
    addDismissTabGesture(in: rootScrollView)
    
    rootScrollView.delegate = self
    addressField.delegate = self
    
  }
  
  //MARK: - Setup Constraints
  func setupConstraints() {
    rootScrollView.snp.makeConstraints {
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
    let dismissButtonAction = dismissButton.rx.tap.asDriver()
    let keyboarWillShow = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillShowNotification)
    let keyboarWillHide = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillHideNotification)
    
    let addPhotoActions = Driver.of(profileButton.rx.tap.asDriver(),
                                   addProfileButton.rx.tap.asDriver()).merge()
    
    let inputCombine = Observable.combineLatest(viewModel.profileImageSubject.take(1),
                                                nameTextField.rx.text.orEmpty,
                                                numberTextField.rx.text.orEmpty,
                                                crewTextField.rx.text.orEmpty,
                                                addressField.rx.text.orEmpty,
                                                emailTextField.rx.text.orEmpty,
                                                birthTextField.rx.text.orEmpty,
                                                memoTextView.rx.text.orEmpty)
    
    let saveButtonAction = saveButton.rx.tap
      .throttle(0.5, scheduler: MainScheduler.instance)
      .withLatestFrom(inputCombine)
    
    let checkSaveValidationAction = Observable.combineLatest(nameTextField.rx.text.orEmpty,
                                                  numberTextField.rx.text.orEmpty,
                                                  crewTextField.rx.text.orEmpty)
    
    let showReceivedAddressAction = rx.viewWillAppear.mapToVoid()
    
    let input = RegistryViewModel.Input(dismissAction: dismissButtonAction,
                                        keyboardWillShowAction: keyboarWillShow,
                                        keyboardWillHideAction: keyboarWillHide,
                                        addPhotoAction: addPhotoActions,
                                        checkSaveValidationAction: checkSaveValidationAction,
                                        saveButtonAction: saveButtonAction,
                                        showReceivedAddressAction: showReceivedAddressAction)
    
    
    //OUTPUT
    let output = viewModel.transform(input: input)
    
    output.dismiss
      .drive()
      .disposed(by: rx.disposeBag)
    
    output.keyboardHeight
      .toContentInset(of: rootScrollView)
      .bind(to: rootScrollView.rx.contentInset)
      .disposed(by: rx.disposeBag)

    output.pickerController
      .drive(onNext: { pickerVC in
        pickerVC.delegate = self
        self.present(pickerVC, animated: true) { App.loading.hide() }
      })
      .disposed(by: rx.disposeBag)
    
    output.saveButtonEnable
      .drive(onNext: { enable in
        print(enable)
        enable ? self.saveButton.activate() : self.saveButton.inActivate()
      })
      .disposed(by: rx.disposeBag)
    
    output.userInfoSave
      .drive()
      .disposed(by: rx.disposeBag)
    
    output.didSetReceivedAddress
      .drive(addressField.rx.text)
      .disposed(by: rx.disposeBag)
    
  }
}

//MARK: - UIImagePickerController
extension RegistryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    let originImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    self.profileButton.setImage(originImage, for: .normal)
    viewModel.profileImageSubject.onNext(self.profileButton.imageView?.image?.pngData())
    self.dismiss(animated: true, completion: nil)
    
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
}

//MARK: - UIScrollViewDelegate
extension RegistryViewController: UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    if scrollView.contentOffset.y >= 190 {
      self.naviTitleLabel.textColor = .black
      self.dismissButton.imageView?.tintColor = .black
      self.saveButton.titleLabel?.textColor = .black
    } else {
      self.naviTitleLabel.textColor = .white
      self.dismissButton.imageView?.tintColor = .white
      self.saveButton.titleLabel?.textColor = .white
    }
    
  }
}

//MARK: - UITextFieldDelegate
extension RegistryViewController: UITextFieldDelegate {
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    dismissKeyboard()
    App.loading.show()
    viewModel.navigator?.navigate(to: .addressSearch)
  }
  
}
