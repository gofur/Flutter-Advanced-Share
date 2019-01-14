import Flutter
import UIKit

public class SwiftAdvancedSharePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "github.com/mrtcndnlr/advanced_share", binaryMessenger: registrar.messenger())
    let instance = SwiftAdvancedSharePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "share":
            let args = call.arguments as! [String:Any]
            let msg = args["msg"] as? String
            let url = args["url"] as? String
            /// currently unused
//            let title = args["title"] as? String
//            let subject = args["subject"] as? String
//            let type = args["type"] as? String
            
            let data:String? = url!.removePrefix(for: "(data:image\\/)([a-zA-Z]*)(;base64,)")
            let dataDecoded:Data = Data(base64Encoded: data!, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            
            let activityVC = UIActivityViewController(activityItems: [decodedimage, msg!], applicationActivities: nil)

            let uvc = UIApplication.shared.keyWindow?.rootViewController
            uvc!.present(activityVC, animated: true, completion: nil)
            
            result(1)
            break
        default:
            result(0)
    }
  }
    
    
}

extension String {
    func removePrefix(for prefix: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: prefix)
            let results = regex.matches(in: self, range:  NSRange(self.startIndex..., in: self))
            let map = results.map {
                String(self[Range($0.range, in: self)!])
            }
            let res = replacingOccurrences(of: map.first!, with: "")
            return res
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}
