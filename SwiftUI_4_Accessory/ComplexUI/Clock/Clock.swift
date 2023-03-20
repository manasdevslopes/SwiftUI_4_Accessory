//
//  Clock.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 20/03/23.
//

import SwiftUI

struct Clock: View {
    var body: some View {
      TimelineView(.animation(minimumInterval: 1 / 20)) { timeline in
        Canvas {ctx, size in
          // Get the current Hand Angles
          let angles = getAngles(for: timeline.date)
          
          // Figure out our drawing space
          let rect = CGRect(origin: .zero, size: size)
          let r = min(size.width, size.height) / 2
          
          // Calculate some size constants
          let border = r / 25
          let hLength = r / 2.5
          let mLength = r / 1.5
          
          ctx.stroke(Circle()
            .inset(by: border / 2)
            .path(in: rect), with: .color(.primary), lineWidth: border)
          ctx.translateBy(x: rect.midX, y: rect.midY)
          
          drawHours(in: ctx, radius: r)
          drawHand(in: ctx, radius: r, length: mLength, angle: angles.minute)
          drawHand(in: ctx, radius: r, length: hLength, angle: angles.hour)
          
          
          let innerRing = r / 6
          let ringWidth = r / 40
          let inner = CGRect(x: -innerRing / 2, y: -innerRing / 2, width: innerRing, height: innerRing)
          ctx.stroke(Circle().path(in: inner), with: .color(.primary), lineWidth: ringWidth)
          
          let sLength = r * 1.1
          let sWidth = r / 25
          let secondLine = Capsule().offset(x: 0, y: -r / 6).rotation(angles.second, anchor: .top)
            .path(in: CGRect(x: -sWidth / 2, y: 0, width: sWidth, height: sLength))
          ctx.fill(secondLine, with: .color(.orange))
          
          
          let centerPiece = Circle().path(in: inner.insetBy(dx: ringWidth, dy: ringWidth))
          ctx.blendMode = .clear
          ctx.fill(centerPiece, with: .color(.white))
          ctx.blendMode = .normal
          ctx.stroke(centerPiece, with: .color(.orange), lineWidth: ringWidth)
          
        }
      }
    }
}

extension Clock  {
  func getAngles(for date: Date) -> (hour: Angle, minute: Angle, second: Angle) {
    let parts = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: .now)
    
    let h = Double(parts.hour ?? 0)
    let m = Double(parts.minute ?? 0)
    let s = Double(parts.second ?? 0)
    let n = Double(parts.nanosecond ?? 0)
    
    /*
    // 360 (circle) / 12 (Total Hour) = 30 (Degree between 2 hours)
    // 360 (Circle) / 60 ( 1min = 60) = 6 (Degree between each minute)
    // Angle = Hour * 30 (For Each Hour) + 180
    // 1'o clock = 1 * 30 = 30°
    // 2'o clock = 2 * 30 = 60°
    // 3'o clock = 3 * 30 = 90°
    //        ...
    // 12'o clock = 12 * 30 = 360°
    */
    
    // Convert time into Angles Degrees
    var hour = Angle.degrees(30 * (h + m / 60) + 180)
    var minute = Angle.degrees(6 * (m + s / 60) + 180)
    var second = Angle.degrees(6 * (s + n / 1_000_000_000) + 180)
    
    if hour.radians == .pi { hour = .radians(3.14158)}
    if minute.radians == .pi { minute = .radians(3.14158)}
    if second.radians == .pi { second = .radians(3.14158)}
    
    return (hour, minute, second)
  }
  
  func drawHand(in context: GraphicsContext, radius: Double, length: Double, angle: Angle) {
    let width = radius / 30 // 30 is just calculation to make the width of hand perfect on screen
    
    let stalk = Rectangle().rotation(angle, anchor: .top)
      .path(in: CGRect(x: -width / 2, y: 0, width: width, height: length))
    context.fill(stalk, with: .color(.primary))
    
    
    let hand = Capsule().offset(x: 0, y: radius / 5)
               .rotation(angle, anchor: .top)
               .path(in: CGRect(x: -width, y: 0, width: width * 2, height: length))
    context.fill(hand, with: .color(.primary))
  }
}

extension Clock {
  func drawHours(in context: GraphicsContext, radius: Double) {
    let textSize = radius / 4
    let textOffset = radius * 0.75
    
    for i in 1...12 {
      let text = Text(String(i)).font(.system(size: textSize)).bold()
      let point = CGPoint(x: 0, y: -textOffset)
        .applying(CGAffineTransform(rotationAngle: Double(i) * .pi / 6))
      
      context.draw(text, at: point)
    }
  }
}

struct Clock_Previews: PreviewProvider {
    static var previews: some View {
        Clock()
    }
}
