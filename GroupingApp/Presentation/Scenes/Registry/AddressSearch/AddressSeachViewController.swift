//
//  AddressSeachViewController.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

class AddressSeachViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {
    
  }


  //MARK: - UI Properties

  let popButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon-Arrow-Left"), for: .normal)
    button.imageView?.tintColor = .black
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let searchBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "SearchBar")
    return view
  }()
  
  let searchTextField: UITextField = {
    let searchBar = UITextField()
    searchBar.placeholder = "주소 검색"
    searchBar.clearButtonMode = .whileEditing
    return searchBar
  }()



  //MARK: - Properties
  typealias ViewModel = AddressSearchViewModel
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

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupConstraint()

  }
}

//MARK: - Bind
extension AddressSeachViewController {

  //OUTPUT
  func command(viewModel: ViewModel) {

    let obDidTapPop = popButton.rx.tap
    .map { ViewModel.Command.pop }
    
    
    Observable<ViewModel.Command>.merge([
      obDidTapPop
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
        case .popState:
          self.navigationController?.popViewController(animated: true)
          
        }
      })
      .disposed(by: self.disposeBag)
  }

}


//MARK: - Method Handler
extension AddressSeachViewController {

  private func setupUI() {
    navigationController?.isNavigationBarHidden = true
    
    setupNavigationBar(at: view, leftItem: popButton)
    [searchBaseView, searchTextField].forEach { view.addSubview($0) }
//    navigationBaseView.backgroundColor = App.color.main
    
  }

  private func setupConstraint() {
    
    searchBaseView.snp.makeConstraints {
      $0.top.equalTo(navigationBaseView.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }
    
    searchTextField.snp.makeConstraints {
      $0.centerY.equalTo(searchBaseView).offset(-2)
      $0.leading.equalToSuperview().offset(80)
      $0.trailing.equalToSuperview().offset(-32)
      $0.height.equalTo(46)
      
    }
  }

}

