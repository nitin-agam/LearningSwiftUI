//
//  RemoveItemsTest.swift
//  ItemAppTestingTests
//
//  Created by Nitin Kumar on 01/12/25.
//

import Testing
@testable import ItemAppTesting

struct RemoveItemsTest {

    @Test("Remove last item")
    func items_when_remove_last_item() {
        
        // given
        let sut = ItemViewModel()
        let itemCount = sut.items.count
        let expectedItemCount = itemCount - 1
        
        // when
        sut.removeLast()
        
        // then
        #expect(sut.items.count == expectedItemCount, "Expected that array has \(expectedItemCount) items")
    }

    @Test("Remove when no items")
    func no_items_then_remove_disabled() {
        
        // given
        let sut = ItemViewModel()
        
        // when
        for _ in 0..<sut.items.count {
            sut.removeLast()
        }
        
        // then
        #expect(sut.deleteDisabled == true, "Removed should be disabled when no items in array")
    }
    
    @Test func no_items_remove_clicked_then_no_action() {
        
        // given
        let sut = ItemViewModel()
        sut.items = []
        
        // when
        sut.removeLast()
        
        // then
        #expect(sut.items.isEmpty == true, "No action should happen when no item")
    }
}
