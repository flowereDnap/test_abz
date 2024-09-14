//
//  usersListView.swift
//  test_abz
//
//  Created by mac on 21.08.2024.
//

import Foundation
import SwiftUI


struct UsersView: View {
    
    @ObservedObject var viewModel: UsersListVM
    
    @State var didScrollAll: Bool = false
    @GestureState private var dragOffset: CGSize = .zero
    @State var wholeSize: CGSize = .zero

    @State var lastId: Int = -1
    
    var body: some View {
        ZStack (alignment: .bottom){
            
            
            VStack(spacing: 24) {
                
                if viewModel.users.count == 0 {
                    Image("no-users-image")
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("There are no users yet")
                        .font(UIConstraints.fontRegular(size: 20))
                    Button {
                        viewModel.fetchNextPage() {
                                lastId = viewModel.users.last?.id ?? -1
                        }
                    } label: {
                        Text("Reload")
                            .font(UIConstraints.fontRegular(size: 20))
                    }.buttonStyle(PrimaryButtonStyle())
                    
                } else {
                    
                    
                    
                    List(viewModel.users) { user in
                        VStack(spacing: 0){
                            UserCellView(user: user)
                            
                            if user.id == lastId {
                                GeometryReader { geometry in
                                    Color.clear
                                        .frame(height: 1)// Minimal height to be visible
                                        .onChange(of: geometry.frame(in: .global).maxY) { maxY in
                                            let screenHeight = UIScreen.main.bounds.height
                                            if maxY < screenHeight {
                                                if !didScrollAll {
                                                    didScrollAll = true
                                                }
                                            } else {
                                                if didScrollAll {
                                                    
                                                    didScrollAll = false
                                                }
                                            }
                                        }
                                }
                                .frame(height: 1)
                                .onDisappear() {
                                    didScrollAll = false
                                }
                            }

                        }
                    }
                    .listStyle(PlainListStyle())
                    .listRowInsets(EdgeInsets())
                    
                }
            }
            .frame(minHeight: 0,
                   maxHeight: .infinity)
            .gesture(negativeDrug)
            
                ProgressView() // Default loader spinner
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
                    .opacity(viewModel.loading ? 1 : 0)
                    .animation(.easeOut(duration: 1), value: viewModel.loading)
        }
        .padding(0)
    }
    
    
    func drug(){
        print("drug inv")
                    viewModel.fetchNextPage() {
                            lastId = viewModel.users.last?.id ?? -1
                    }
                
    }
    
    var negativeDrug: some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, transaction in
                state = value.translation
                if state.height < -10 && didScrollAll {
                    drug()
                    }
            }
       }
}




struct UsersView_Previews: PreviewProvider {
    struct Wrapper: View {
        
        @StateObject var vm = AlertVM()
        @StateObject var model = Model()
        var body: some View {
            UsersView(viewModel: UsersListVM(alertVM: vm, model: model)).environmentObject(UsersListVM(alertVM: vm, model: model))
        }
    }
    
    static var previews: some View {
        Wrapper()
    }
}
