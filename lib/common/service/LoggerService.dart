

import 'package:loggy/loggy.dart';

class LoggerService with UiLoggy {
  
  // https://github.com/infinum/floggy


 DoSomeWork() {
   loggy.debug('This is debug message');
   loggy.info('This is info message');
   loggy.warning('This is warning message');
   loggy.error('This is error message');
 }

 // dio log
 // at IntelliJ 
 // Set up this is by going to Preferences -> Editor -> General -> 
 // Console and under Fold console lines that contain add these 3 rules: ║, ╔ and ╚.
}