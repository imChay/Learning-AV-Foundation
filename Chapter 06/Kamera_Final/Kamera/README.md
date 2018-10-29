- 设置会话类型，并激活；
- 配置会话的输入、输出；
- 将会话连接到预览图层 AVCaptureVideoPreviewLayer；
- 开启会话；

- 开始录制：
AVCaptureMovieFileOutput 创建连接对象 AVCaptureConnection,设置连接对象相关属性
AVCaptureMovieFileOutput 开始录制输出到指定的目录（打开管道的阀门，开始泄水）
```
[self.movieOutput startRecordingToOutputFileURL:self.outputURL     
recordingDelegate:self];
```
- 开始拍照：
```
[self.imageOutput captureStillImageAsynchronouslyFromConnection:connection
completionHandler:handler];
```
