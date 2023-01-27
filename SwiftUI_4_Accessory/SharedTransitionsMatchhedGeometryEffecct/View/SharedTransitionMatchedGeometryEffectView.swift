//
//  SharedTransitionMatchedGeometryEffectView.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 27/01/23.
//

import SwiftUI

struct SharedTransitionMatchedGeometryEffectView: View {
  @State private var videoFiles: [VideoFile] = files
  @State private var expandedID: String?
  @State private var isExpanded: Bool = false
  @Namespace private var namespace
  
    var body: some View {
      VStack(spacing: 0) {
        HeaderView()
        
        /// - Lazy Grid
        ScrollView(.vertical, showsIndicators: false) {
          LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 2), spacing: 10) {
            ForEach($videoFiles) { $file in
              if expandedID == file.id.uuidString && isExpanded {
                Rectangle().foregroundColor(.clear).frame(height: 300)
              } else {
                CardView(videoFile: $file, isExpanded: $isExpanded, animationID: namespace) {
                  
                }
                .frame(height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                  withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.8)) {
                    expandedID = file.id.uuidString
                    isExpanded = true
                  }
                }
              }
            }
          }
          .padding(.horizontal, 15)
          .padding(.vertical, 10)
        }
      }
      .overlay {
        if let expandedID, isExpanded {
          /// - Displaying DetailView with Animation
          DetailView(videoFile: $videoFiles.index(expandedID), isExpanded: $isExpanded, animationID: namespace)
          /// - Adding Transition for Smooth Expansion
            .transition(.asymmetric(insertion: .identity, removal: .offset(y: 5)))
        }
      }
    }
}

/// - DetailView
struct DetailView: View {
  @Binding var videoFile: VideoFile
  @Binding var isExpanded: Bool
  var animationID: Namespace.ID
  
  @GestureState private var isDragging: Bool = false
  
  var body: some View {
    GeometryReader {
      let safeArea = $0.safeAreaInsets
      
      CardView(videoFile: $videoFile, isExpanded: $isExpanded, animationID: animationID, isDetailView: true) {
        OverlayView()
          .padding(.top, safeArea.top)
          .padding(.bottom, safeArea.bottom)
      }
      .ignoresSafeArea()
    }
    .gesture(
      DragGesture()
        .updating($isDragging, body: { _, out, _ in
          out = true
        })
        .onChanged({ value in
          var translation = value.translation
          translation = isDragging ? translation : .zero
          videoFile.offset = translation
        }).onEnded({ value in
          if value.translation.height > 200 {
            /// - Closing View with Animation
            videoFile.player.pause()
            
            /// - First Closing View And in the Mid of Animation Resetting the Player to Start & Hiding the Video View
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
              videoFile.player.seek(to: .zero)
              videoFile.playVideo = false
            }
            
            withAnimation(.interactiveSpring(response: 0.3, dampingFraction: 0.7, blendDuration: 0.7)) {
              videoFile.offset = .zero
              isExpanded = false
            }
          } else {
            withAnimation(.easeInOut(duration: 0.25)) {
              videoFile.offset = .zero
            }
          }
        })
    )
    .onAppear {
      /// - play the video as soon as the animation finishes
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.28) {
        withAnimation(.easeInOut) {
          videoFile.playVideo = true
          videoFile.player.play()
        }
      }
    }
  }
  
  @ViewBuilder
  func OverlayView() -> some View {
    VStack {
      HStack {
        Image("manas_iosdev")
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 35, height: 35)
          .clipShape(Circle())
        VStack(alignment: .leading, spacing: 4) {
          Text("_iosmanas")
            .font(.callout)
            .fontWeight(.bold)
          
          Text("4 hr ago")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
        Image(systemName: "bookmark")
          .font(.title3)
        
        Image(systemName: "ellipsis")
          .font(.title3)
          .rotationEffect(.init(degrees: -90))
      }
      .foregroundColor(.white)
      .frame(maxHeight: .infinity, alignment: .top)
      /// - Hiding when dragging
      .opacity(isDragging ? 0 : 1)
      .animation(.easeInOut(duration: 0.2), value: isDragging)
      
      Button {} label: {
        Text("View More Episodes")
          .font(.callout)
          .fontWeight(.bold)
          .foregroundColor(.black)
          .padding(.horizontal,12)
          .padding(.vertical, 8)
          .background {
            Capsule()
              .fill(.white)
          }
      }
      .frame(maxWidth: .infinity)
      .overlay(alignment: .trailing) {
        Button {
          
        } label: {
          Image(systemName: "paperplane.fill")
            .font(.title3)
            .foregroundColor(.white)
            .frame(width: 40, height: 40)
            .background {
              Circle()
                .fill(.ultraThinMaterial)
            }
        }

      }
    }
    .padding(.horizontal, 15)
    .padding(.vertical, 10)
    /// - Displaying only when video startes playing
    .opacity(videoFile.playVideo && isExpanded ? 1 : 0)
  }
}

/// - Fetching Binding indexOf
extension Binding<[VideoFile]> {
  func index(_ id: String) -> Binding<VideoFile> {
    let index = self.wrappedValue.firstIndex { item in
      item.id.uuidString == id
    } ?? 0
    return self[index]
  }
}

struct SharedTransitionMatchedGeometryEffectView_Previews: PreviewProvider {
    static var previews: some View {
        SharedTransitionMatchedGeometryEffectView()
    }
}

extension SharedTransitionMatchedGeometryEffectView {
  /// - Header View
  @ViewBuilder
  func HeaderView() -> some View {
    HStack(spacing: 12) {
      Image("manas_iosdev")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 25, height: 25)
        .headerButtonBG()
      
      Button {} label: {
        Image(systemName: "magnifyingglass")
          .fontWeight(.semibold)
          .foregroundColor(.black)
          .headerButtonBG()
      }

      Spacer(minLength: 0)
      
      Button {} label: {
        Image(systemName: "person.badge.plus")
          .fontWeight(.semibold)
          .foregroundColor(.black)
          .headerButtonBG()
      }
      
      Button {} label: {
        Image(systemName: "ellipsis")
          .fontWeight(.semibold)
          .foregroundColor(.black)
          .headerButtonBG()
          .rotationEffect(Angle(degrees: 90))
      }
    }
    .overlay {
      Text("Stories")
        .font(.title3)
        .fontWeight(.black)
    }
    .padding(.horizontal, 15)
    .padding(.vertical, 10)
  }
}

/// - Custom View Modeifier
extension View {
  func headerButtonBG() -> some View {
    self
      .frame(width: 40, height: 40)
      .background {
        Circle()
          .fill(.gray.opacity(0.1))
      }
  }
}
