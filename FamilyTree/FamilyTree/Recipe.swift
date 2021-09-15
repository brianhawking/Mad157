//
//  Recipe.swift
//  FamilyTree
//
//  Created by Brian Veitch on 9/14/21.
//
/*
 
Directions
 
    1. Start with current family member
    2. Shows a tableview of all immediate family members
    3. Four buttons to allow you to add new family members
    4. Click on family member to set them as the current family member
    5. Then you can add their immmediately family members
 
Controllers

    - TitleControler: displays the title FamilyTree
    - ViewController: main controller. Shows the current family member and all their immediate family members
    - AddMemberController: add immediate family member to current member
    - ViewInfoController: shows member name and description
 
 TitleController
 
    - Variables
        None
    - Functions
        performssegue: get to main controller
        set a timer to do this
 
 ViewController (main)
 
    Classes
        Person
            - Variables
                name: String
                id: Int
                partners: [Int] of ids
                parents: [Int] of ids
                siblings: [Int] of ids
                children: [Int] of ids
                
 
    - Variables
        id - id of member shown
        Person - class
        persons: [Person] - array of persons
        addType: are you adding a parent, child, sibling, or partner
        
 
    - Need tableview controller to list immediaate family members
 
    - Functions
        openInfoAction - takes you to the family member description
        addMemberAction - takes you to controller to add new member
        prepare() - prepare segue to send information to new controller
 
 AddMemberController
 
    - Variables
        person - current family member, contains id and name
        persons - array of all existing family members
        availabile - array of existing family members that the current one can select. Avoids repeats
        id - This will be the id of newly added family member
        
        completionHandler - send data back to viewcontroller to update family tree
 
    - Functions
 
        Tableview functions
            - didsselect so I can populate name and description of existing family member
        
        saveAction
            - if data correctly entered, completionhadler sets values to send back to viewcontroller
 
 ViewInfoController
 
    - Variables
        name - name of family member
        description - description of family member
        
    - Functions
        dismiss segue - go back to family tree
 
 */
