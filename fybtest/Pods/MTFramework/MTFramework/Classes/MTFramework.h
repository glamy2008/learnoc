//
//  MTFramework.h
//  Pods
//
//  Created by Jason Li on 2018/4/18.
//

#ifndef MTFramework_h
#define MTFramework_h

#ifdef DEBUG
#define MDLog(...) NSLog(@"%s,:%@", __func__, [NSString stringWithFormat: __VA_ARGS__])
#define MDDLog(...) NSLog(@"\n{类名}:%s,\n{行数}:%d\n{NSLog}:%@ \n\n", __func__, __LINE__, [NSString stringWithFormat: __VA_ARGS__])
#else
#   define MDDLog(...) /* */
#   define MDLog(...) /* */
#endif

#define MDLogFunc MDLog(@"%s",__func__)
#define MDDLogFunc MDDLog(@"%s",__func__)
#define MDLogFuncStr(str) MDLog(@"%s,%@",__func__,str)
#define MDDLogFuncStr(str) MDDLog(@"%s,%@",__func__,str)

#endif /* MTFramework_h */
