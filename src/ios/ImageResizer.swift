@objc(ImageResizer) class ImageResizer : CDVPlugin {
    
    @objc(resize:) func resize(_ command: CDVInvokedUrlCommand) {
        
        let pluginResult = CDVPluginResult(
            status: CDVCommandStatus_OK,
            messageAs: true
        )
        
        print(command.arguments[0])
        
        self.commandDelegate!.send(
            pluginResult,
            callbackId: command.callbackId
        )
    }
    
}
