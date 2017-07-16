//
//  AddTodoTaskDelegate.swift
//  ToDoList
//
//  Created by Seth Bishop on 7/15/17.
//  Copyright © 2017 Seth Bishop. All rights reserved.
//

import Foundation

import UIKit

protocol AddToDoTaskDelegate: class {
    
    func AddTodoTask(title: String, notes: String, date: Date)
    
}
