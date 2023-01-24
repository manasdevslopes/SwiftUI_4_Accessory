//
//  NativePopover.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 24/01/23.
//

import SwiftUI

enum Direction: String, CaseIterable {
  case up = "Up"
  case down = "Down"
  case left = "Left"
  case right = "Right"
  
  var directions: UIPopoverArrowDirection {
    switch self {
      case .up:
        return .up
      case .down:
        return .down
      case .left:
        return .left
      case .right:
        return .right
    }
  }
}

enum BG: String, CaseIterable {
  case def = "Default"
  case blues = "Blue"
  case Reds = "Red"
  case Oranges = "Orange"
  
  var color: Color {
    switch self {
      case .def: return Color(.clear)
      case .Oranges: return Color(.orange)
      case .Reds: return Color(.red)
      case .blues: return Color(.blue)
    }
  }
}


struct NativePopover: View {
  @State private var showPopover: Bool = false
  @State private var updateText: Bool = false
  @State private var arrorDirection: Direction = .up
  @State private var bg: BG = .def
  
  var body: some View {
    VStack(alignment: .leading) {
      Section {
        Picker("Arrow Direction", selection: $arrorDirection) {
          ForEach(Direction.allCases,id: \.self) { direction in
            Text("\(direction.rawValue)")
          }
        }
        .pickerStyle(.segmented)
      } header: {
        Text("Arrow Direction")
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(.gray)
      }

      Section {
        Picker("Background", selection: $bg) {
          ForEach(BG.allCases,id: \.self) { bg in
            Text("\(bg.rawValue)")
          }
        }
        .pickerStyle(.segmented)
      } header: {
        Text("Background")
          .font(.caption)
          .fontWeight(.bold)
          .foregroundColor(.gray)
      }
      
      Button("Show Popover") {
        showPopover.toggle()
      }
      .iOSPopover(isPresented: $showPopover, arrowDirection: arrorDirection.directions) {
        VStack(spacing: 12) {
          Text("Hello, it's me, \(updateText ? "Updated Popover" : "Popover").")
          Button("Update Text") {
            updateText.toggle()
          }
          Button("Close Popover") {
            showPopover.toggle()
          }
        }
        .foregroundColor(bg == .def ? .black : .white)
        .padding(15)
        .background {
          Rectangle()
            .fill(bg.color.gradient)
            .padding(-20)
        }
      }
      .padding(.top, 20)
      
      Spacer()
    }
    .padding(16)
    .navigationTitle("iOS Popovers")
  }
}

struct NativePopover_Previews: PreviewProvider {
  static var previews: some View {
    NativePopover()
  }
}

/// - Eabling Popover for iOS
extension View {
  @ViewBuilder
  func iOSPopover<T: View>(isPresented: Binding<Bool>, arrowDirection: UIPopoverArrowDirection, @ViewBuilder content: () -> T) -> some View {
    
    self
      .background {
        PopOverController(isPresented: isPresented, arrowDirection: arrowDirection, content: content())
      }
  }
}

/// - Popover Helper
struct PopOverController<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  var arrowDirection: UIPopoverArrowDirection
  var content: Content
  
  @State private var alreadyPresented: Bool = false
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }
  
  func makeUIViewController(context: Context) -> UIViewController {
    let controller = UIViewController()
    controller.view.backgroundColor = .clear
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    if alreadyPresented {
      /// - Updating SwiftUI View when its Changed
      if let hoistingController = uiViewController.presentedViewController as? CustomHoistingView<Content> {
        hoistingController.rootView = content
        hoistingController.preferredContentSize = hoistingController.view.intrinsicContentSize
      }
      
      /// - Close View, if it's toggled back
      print(isPresented)
      if !isPresented {
        /// - Closing Popover
        uiViewController.dismiss(animated: true) {
          alreadyPresented = false
        }
      }
    } else {
      /// - if isPresented
      if isPresented {
        let controller = CustomHoistingView(rootView: content)
        controller.view.backgroundColor = .clear
        controller.modalPresentationStyle = .popover
        controller.popoverPresentationController?.permittedArrowDirections = arrowDirection
        controller.presentationController?.delegate = context.coordinator
        controller.popoverPresentationController?.sourceView = uiViewController.view
        uiViewController.present(controller, animated: true)
      }
    }
    
  }
  
  class Coordinator: NSObject, UIPopoverPresentationControllerDelegate {
    var parent: PopOverController
    init(parent: PopOverController) {
      self.parent = parent
    }
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
      return .none
    }
    
    func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
      parent.isPresented = false
    }
    
    /// - When the popover is presented, updating the alreadyPresented state
    func presentationController(_ presentationController: UIPresentationController, willPresentWithAdaptiveStyle style: UIModalPresentationStyle, transitionCoordinator: UIViewControllerTransitionCoordinator?) {
      DispatchQueue.main.async {
        self.parent.alreadyPresented = true
      }
    }
  }
}

class CustomHoistingView<Content: View>: UIHostingController<Content> {
  override func viewDidLoad() {
    super.viewDidLoad()
    preferredContentSize = view.intrinsicContentSize
  }
}
