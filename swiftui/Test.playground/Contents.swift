import Cocoa

struct Price {
   var USD: Double
   var ratetoCAD: Double
   var ratetoUSD: Double
 
   var canadians: Double {
      get {
         return USD * ratetoCAD
      }
      set(CAD) {
         USD = CAD * ratetoUSD
      }
   }
}
var purchase = Price(USD: 11, ratetoCAD: 1.29, ratetoUSD: 0.7752)
print(purchase.canadians)
