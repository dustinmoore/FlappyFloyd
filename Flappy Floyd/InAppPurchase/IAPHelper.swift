//
//  IAPHelper.swift
//  Flappy Floyd
//
//  Created by Dustin Moore on 10/27/19.
//  Copyright © 2019 Dustin Moore. All rights reserved.
//

import StoreKit

public typealias ProductIdentifier = String
public typealias ProductsRequestCompletionHandler = (_ success: Bool, _ products: [SKProduct]?) -> Void

extension Notification.Name {
    static let IAPHelperPurchaseNotification = Notification.Name("IAPHelperPurchaseNotification")
}

open class IAPHelper: NSObject  {
    
    private let productIdentifiers: Set<ProductIdentifier>
    private var purchasedProductIdentifiers: Set<ProductIdentifier> = []
    private var productsRequest: SKProductsRequest?
    private var productsRequestCompletionHandler: ProductsRequestCompletionHandler?
    private let iCloudDefaults = NSUbiquitousKeyValueStore.default
    
    public init(productIds: Set<ProductIdentifier>) {
        productIdentifiers = productIds
        for productIdentifier in productIds {
            let purchased = UserDefaults.standard.bool(forKey: productIdentifier)
            if purchased {
                purchasedProductIdentifiers.insert(productIdentifier)
                print("Previously purchased: \(productIdentifier)")
            } else {
                print("Not purchased: \(productIdentifier)")
            }
        }
        super.init()
        
        SKPaymentQueue.default().add(self)
    }
}

extension IAPHelper {
    
    public func requestProducts(_ completionHandler: @escaping ProductsRequestCompletionHandler) {
        productsRequest?.cancel()
        productsRequestCompletionHandler = completionHandler
        
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest!.delegate = self
        productsRequest!.start()
    }
    
    public func buyProduct(_ product: SKProduct) {
        print("Buying \(product.productIdentifier)...")
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
        return purchasedProductIdentifiers.contains(productIdentifier)
    }
    
    public class func canMakePayments() -> Bool {
        return SKPaymentQueue.canMakePayments()
    }
    
    public func restorePurchases() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}

extension IAPHelper: SKProductsRequestDelegate {
    
    public func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Loaded list of products...")
        let products = response.products
        productsRequestCompletionHandler?(true, products)
        clearRequestAndHandler()
        
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }
    
    public func request(_ request: SKRequest, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error.localizedDescription)")
        productsRequestCompletionHandler?(false, nil)
        clearRequestAndHandler()
    }
    
    private func clearRequestAndHandler() {
        productsRequest = nil
        productsRequestCompletionHandler = nil
    }
}

extension IAPHelper: SKPaymentTransactionObserver {
    
    public func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                complete(transaction: transaction)
                break
            case .failed:
                fail(transaction: transaction)
                break
            case .restored:
                restore(transaction: transaction)
                break
            case .deferred:
                break
            case .purchasing:
                break
            }
        }
    }
    
    private func complete(transaction: SKPaymentTransaction) {
        print("complete...")
        if transaction.payment.productIdentifier == "PREMIUMFLOYD2019" {
            let purchasedGems = 1000
            let currentGems = iCloudDefaults.object(forKey: "gems") as! Int
            iCloudDefaults.set(currentGems+purchasedGems, forKey: "gems")
            iCloudDefaults.set(1, forKey: "skin2")
            iCloudDefaults.set(1, forKey: "skin3")
            iCloudDefaults.set(1, forKey: "skin4")
            iCloudDefaults.set(1, forKey: "skin5")
            iCloudDefaults.set(1, forKey: "skin6")
            iCloudDefaults.set(1, forKey: "skin7")
            iCloudDefaults.set(1, forKey: "skin8")
            iCloudDefaults.set(1, forKey: "skin9")
            iCloudDefaults.set(1, forKey: "skin10")
            iCloudDefaults.set(1, forKey: "skin11")
            iCloudDefaults.set(1, forKey: "skin12")
            iCloudDefaults.synchronize()
        } else if transaction.payment.productIdentifier == "1000GEMS" {
            let purchasedGems = 1000
            let currentGems = iCloudDefaults.object(forKey: "gems") as! Int
            iCloudDefaults.set(currentGems+purchasedGems, forKey: "gems")
            iCloudDefaults.synchronize()
        } else if transaction.payment.productIdentifier == "2500GEMS" {
            let purchasedGems = 2500
            let currentGems = iCloudDefaults.object(forKey: "gems") as! Int
            iCloudDefaults.set(currentGems+purchasedGems, forKey: "gems")
            iCloudDefaults.synchronize()
        } else if transaction.payment.productIdentifier == "5000GEMS" {
            let purchasedGems = 5000
            let currentGems = iCloudDefaults.object(forKey: "gems") as! Int
            iCloudDefaults.set(currentGems+purchasedGems, forKey: "gems")
            iCloudDefaults.synchronize()
        }
        deliverPurchaseNotificationFor(identifier: transaction.payment.productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func restore(transaction: SKPaymentTransaction) {
        guard let productIdentifier = transaction.original?.payment.productIdentifier else { return }
        
        print("restore... \(productIdentifier)")
        deliverPurchaseNotificationFor(identifier: productIdentifier)
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func fail(transaction: SKPaymentTransaction) {
        print("fail...")
        if let transactionError = transaction.error as NSError?,
            let localizedDescription = transaction.error?.localizedDescription,
            transactionError.code != SKError.paymentCancelled.rawValue {
            print("Transaction Error: \(localizedDescription)")
        }
        
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    private func deliverPurchaseNotificationFor(identifier: String?) {
        guard let identifier = identifier else { return }
        
        purchasedProductIdentifiers.insert(identifier)
        UserDefaults.standard.set(true, forKey: identifier)
        NotificationCenter.default.post(name: .IAPHelperPurchaseNotification, object: identifier)
    }
}
