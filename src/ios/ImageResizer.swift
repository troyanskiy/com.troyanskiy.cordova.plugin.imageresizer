import Foundation

@objc(ImageResizer) class ImageResizer : CDVPlugin {
    
    @objc(resize:) func resize(_ command: CDVInvokedUrlCommand) {
        
        self.commandDelegate!.run(inBackground: {
            
            let src = command.arguments[0] as! String;
            let dst = command.arguments[1] as! String;
            //        let srcOffsetX = command.arguments[2]
            //        let srcOffsetY = command.arguments[3]
            //        var srcWidth = command.arguments[4]
            //        var srcHeight = command.arguments[5]
            //        let dstOffsetX = command.arguments[6]
            //        let dstOffsetY = command.arguments[7]
            let dstWidth = command.arguments[8] as? Double ?? 0.0;
            let dstHeight = command.arguments[9] as? Double ?? 0.0;
            
            var pluginResult: CDVPluginResult

            pluginResult = CDVPluginResult(
                status: CDVCommandStatus_OK,
                messageAs: true
            );


            //print("Crearing url");
            let url = URL(string: src);
            let data: Data;
            do {
                data = try Data(contentsOf: url! as URL);
            } catch {
                print("ImageResizer Error: Source image does not exists");
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: "Seems src file does not exists"
                );
                self.commandDelegate!.send(
                    pluginResult,
                    callbackId: command.callbackId
                );
                return;
            }

            let srcImage = UIImage(data: data as Data);

            if (srcImage != nil) {
                let srcWidth: Double = Double((srcImage?.size.width)!);
                let srcHeight: Double = Double((srcImage?.size.height)!);

                let ratio: Double = min(dstWidth / srcWidth, dstHeight / srcHeight);

                let newWidth = srcWidth * ratio;
                let newHeight = srcHeight * ratio;

                let newRect: CGRect = CGRect(x: 0.0, y: 0.0, width: CGFloat(newWidth), height: CGFloat(newHeight));
                UIGraphicsBeginImageContext(newRect.size);
                srcImage?.draw(in: newRect);

                let dstImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
                UIGraphicsEndImageContext();
                do {
                    try UIImagePNGRepresentation(dstImage)?.write(to: URL(string: dst)!);
                } catch {
                    pluginResult = CDVPluginResult(
                        status: CDVCommandStatus_ERROR,
                        messageAs: "File was not saved"
                    );
                }

            } else {
                pluginResult = CDVPluginResult(
                    status: CDVCommandStatus_ERROR,
                    messageAs: "File is not an image"
                );
            }

                        //let imageDate:Data = UIImageJPEGRepresentation(dstImage, 1.0)!;
            
            
            //print(srcWidth, srcHeight, dstWidth, dstHeight, ratio, newWidth, newHeight, dstImage.size);
            
            
            self.commandDelegate!.send(
                pluginResult,
                callbackId: command.callbackId
            );

        })
        
        
    }
    
}
