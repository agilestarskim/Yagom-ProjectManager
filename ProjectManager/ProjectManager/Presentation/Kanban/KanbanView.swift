//
//  KanbanView.swift
//  ProjectManager
//
//  Created by Minsup & Whales on 2023/09/20.
//

import SwiftUI

struct KanbanView: View {
    @ObservedObject private var kanbanViewModel: KanbanViewModel
    
    init(kanbanViewModel: KanbanViewModel = KanbanViewModel.mock) {
        self.kanbanViewModel = kanbanViewModel
    }
    
    var body: some View {        
        NavigationStack {
            HStack {
                ColumnView(tasks: kanbanViewModel.todos, title: "TODO")
                ColumnView(tasks: kanbanViewModel.doings, title: "DOING")
                ColumnView(tasks: kanbanViewModel.dones, title: "DONE")
            }
            .background(.quaternary)
            .navigationTitle("Project Manager")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        kanbanViewModel.setFormVisible(true)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }        
        .customAlert(isOn: $kanbanViewModel.isFormOn, title: "Todo") {
            TaskFormView()
        }
        .environmentObject(kanbanViewModel)
    }
}

struct KanbanView_Previews: PreviewProvider {
    static var previews: some View {
        KanbanView(kanbanViewModel: KanbanViewModel.mock)
    }
}
