//
//  DrawingView.swift
//
//
//  Created by Danilo Hernandez on 12/01/24.
//

import SwiftUI


public struct DrawingView: View {
    
    
    @State public var currentLine = LineModel()
    @State public var lines: [LineModel] = []
    @State public var lineWidthSelect: Double = 1.0
    @State public var isSavingImage = false
    @Binding public var uiimage: UIImage?
    @State public var activeLineWidth: Bool = false
    @State public var multipleColor: Bool = false
    @State public var rect1: CGRect = .zero
    @State public var colors: [Color] = [.black]
    @StateObject public var viewModel: DrawingViewModel = DrawingViewModel()
    
    public init(activeLineWidth: Bool, multipleColor: Bool,colors: [Color], uiimage: Binding<UIImage?>) {
        self.activeLineWidth = activeLineWidth
        self.colors = colors
        self._uiimage = uiimage
    }
    
    public var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .background(RectGetterView(rect: $rect1))
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .frame(minWidth: 200, minHeight: 200)
            .shadow(radius: 15)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                })
                    .onEnded({ value in
                        self.lines.append(currentLine)
                        self.currentLine = LineModel(points: [], color: currentLine.color, lineWidth: lineWidthSelect)
                    }))
            
            HStack {
                if activeLineWidth {
                    addSliderWidth()
                }
                if multipleColor {
                    addColorPicker()
                }
                Spacer()
                Button(action: {
                    lines = []
                }, label: {
                    Label("Limpiar", systemImage: "eraser.fill")
                }).padding()
            }
//            if uiimage != nil {
//                VStack {
//                    Text("Captura")
//                    Image(uiImage: self.uiimage!)
//                        .resizable()
//                        .frame(width: 50, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                        .padding(20)
//                        .border(Color.black)
//                }.padding(20)
//            }
            
            Button(action: {
                print("ontapp")
                returnImage { result in
                    switch result {
                        case .success(let success):
                            self.uiimage = success
                        case .failure(let failure):
                            print(failure)
                    }
                }
            }) {
                Text("Guardar imagen")
            }
            .padding()
            .disabled(lines.isEmpty)
        }
        .padding()
    }
    @ViewBuilder
    func addColorPicker () -> some View {
        ColorPickerView(selectedColor: $currentLine.color)
            .onChange(of: currentLine.color) { newColor in
                currentLine.color = newColor
            }
    }
    @ViewBuilder
     func addSliderWidth () -> some View{
       
            
            Slider(value: $lineWidthSelect, in: 1...20) {}
            .frame(maxWidth: 200)
            .onChange(of: lineWidthSelect) { newThickness in
                currentLine.lineWidth = newThickness
            }
            Divider()
    }
    public func returnImage(completion: @escaping(Result<UIImage, Error>) -> ()) {
       if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first {
           guard let image = window.rootViewController?.view.asImage(rect: self.rect1) else {
               completion(.failure(NSError(domain: "No se logró tomar la imagen", code: 400)))
               return }
           completion(.success(image))
       } else {
           completion(.failure(NSError(domain: "No se logró tomar la iamgen", code: 400)))
       }
    }
}

#Preview {
    DrawingView(activeLineWidth: true, multipleColor: true, colors: [.black], uiimage: .constant(nil))
}
