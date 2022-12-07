//
//  YoutubeViewChart.swift
//  SwiftUI_4_Accessory
//
//  Created by MANAS VIJAYWARGIYA on 07/12/22.
//

import SwiftUI
import Charts

struct YoutubeViewChart: View {
  let viewMonths: [ViewMonth] = [
    .init(date: Date.from(year: 2023, month: 1, day: 1), viewCount: 55000),
    .init(date: Date.from(year: 2023, month: 2, day: 1), viewCount: 89000),
    .init(date: Date.from(year: 2023, month: 3, day: 1), viewCount: 64000),
    .init(date: Date.from(year: 2023, month: 4, day: 1), viewCount: 79000),
    .init(date: Date.from(year: 2023, month: 5, day: 1), viewCount: 130000),
    .init(date: Date.from(year: 2023, month: 6, day: 1), viewCount: 90000),
    .init(date: Date.from(year: 2023, month: 7, day: 1), viewCount: 88000),
    .init(date: Date.from(year: 2023, month: 8, day: 1), viewCount: 64000),
    .init(date: Date.from(year: 2023, month: 9, day: 1), viewCount: 74000),
    .init(date: Date.from(year: 2023, month: 10, day: 1), viewCount: 99000),
    .init(date: Date.from(year: 2023, month: 11, day: 1), viewCount: 110000),
    .init(date: Date.from(year: 2023, month: 12, day: 1), viewCount: 94000),
  ]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 4) {
      
      Text("YouTube Views")
      
      Text("Total: \(viewMonths.reduce(0, { $0 + $1.viewCount }))")
        .fontWeight(.semibold)
        .font(.footnote)
        .foregroundColor(.secondary)
        .padding(.bottom, 12)
      
      ScrollView {
        // MARK: - BarMark Chart
        Text("BarMark Chart")
        Chart {
          // Behind the Bars
          RuleMark(y: .value("Goal", 80000))
            .foregroundStyle(Color.mint)
            .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
            .annotation(alignment: .leading) {
              Text("Goal")
                .font(.caption)
                .foregroundColor(.secondary)
            }
          ForEach(viewMonths) { viewMonth in
            BarMark(x: .value("Month", viewMonth.date, unit: .month),
                    y: .value("Views", viewMonth.viewCount)
            )
            .foregroundStyle(Color.pink.gradient)
            .cornerRadius(2) // 0 for no conerRadius or some value
          }
          // Front from Bars
          // RuleMark(y: .value("Goal", 80000))
        }
        .frame(height: 180)
        // .chartXAxis(.hidden) // to hide labels on X Axis
        // .chartYAxis(.hidden) // to hide labels on Y Axis
        // .chartYScale(domain: 0...200000) // to change Y Axis range
        // change content of X Axis - this also hides vertical grid lines
        .chartXAxis {
          // AxisMarks() // gives deafault value in X Axis
          AxisMarks(values: viewMonths.map { $0.date }) {date in
            AxisGridLine()
            AxisTick()
            AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
          }
        }
        // change content of Y Axis - this also hides horizontal grid lines
        .chartYAxis {
          AxisMarks(position: .trailing) {mark in // position is leading, trailing
            AxisValueLabel()
            AxisGridLine()
          }
        }
        
        .chartPlotStyle { plotContent in
          plotContent
            .background(.mint.gradient.opacity(0.34))
            .border(.green, width: 1)
        }
        
        // MARK: - LineMark Chart
        Text("LineMark Chart")
        Chart {
          ForEach(viewMonths) { viewMonth in
            LineMark(x: .value("Month", viewMonth.date, unit: .month),
                     y: .value("Views", viewMonth.viewCount)
            )
            .foregroundStyle(Color.pink.gradient)
          }
        }
        .frame(height: 180)
      }
      
      HStack {
        Image(systemName: "line.diagonal")
          .rotationEffect(Angle(degrees: 45))
          .foregroundColor(.mint)
        
        Text("Monthly Goal")
          .foregroundColor(.secondary)
      }
      .font(.caption2)
      .padding(.leading, 4)
    }
    .padding()
  }
}

struct YoutubeViewChart_Previews: PreviewProvider {
  static var previews: some View {
    YoutubeViewChart()
  }
}

struct ViewMonth: Identifiable {
  let id = UUID()
  let date: Date
  let viewCount: Int
}

extension Date {
  static func from(year: Int, month: Int, day: Int) -> Date {
    let components = DateComponents(year: year, month: month, day: day)
    return Calendar.current.date(from: components)!
  }
}
