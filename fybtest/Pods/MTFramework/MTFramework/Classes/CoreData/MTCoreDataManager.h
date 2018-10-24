//
//  MTCoreDataManager.h
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

@import Foundation;
@import UIKit;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN
@interface MTCoreDataManager : NSObject
/**
 CoreData文件名称，modelName.xcdatamodeld文件
 */
@property (nonatomic, strong) NSString *modelName;

/**
 CoreData管理对象
 */
@property (nonatomic, strong, readonly) NSManagedObjectContext *dataContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *dataModel;
@property (nonatomic, strong, readonly)
NSPersistentStoreCoordinator *dataCoordinator;

/**
 单例方法
 @return JLCoreDataManager实例
 */
+ (instancetype)sharedInstance;

/**
 通过实体名称字符串实例化实体描述对象
 
 @param name 实体名称（表明）
 @return 实体描述对象
 */
- (NSEntityDescription *)entityWithName:(NSString *)name;

/**
 获取数据库存储路径
 
 @return 路径
 */
- (NSURL *)documentsDirectory;

//MARK: - 插入
/**
 创建一个可以操作记录对象
 
 @param name 实体名称
 @return 数据对象 NSManagedObject
 */
- (NSManagedObject *)insertWithEntityName:(NSString *)name;

//MARK: - 删除
/**
 删除并保存所有查询请求结果集记录
 
 @param request 查询请求对象
 @return YES删除成功，NO查询异常或保存失败
 */
- (BOOL)deleteWithRequet:(NSFetchRequest *)request;

/**
 删除并保存指定记录对象
 
 @param object 数据对象 NSManagedObject
 @return YES删除并保存成功，NO保存失败
 */
- (BOOL)deleteWithManagedObject:(NSManagedObject *)object;

//MARK: - 修改&保存
/**
 修改并保存指定记录对象
 
 @param object 数据对象 NSManagedObject
 @return YES修改并保存成功，NO保存失败
 */
- (BOOL)updateWithManagedObject:(NSManagedObject *)object;

/**
 保存指定记录对象
 
 @param object 数据对象 NSManagedObject
 @return YES修保存成功，NO保存失败
 */
- (BOOL)saveWithManagedObject:(NSManagedObject *)object;

//MARK: - 查询
/**
 获取CoreDate查询请求对象
 
 @param name 实体描述对象名称
 @param predicate 筛选谓词
 @param sortDescriptors 排序数组@[NSSortDescriptor]
 @return FetchRequest实例
 */
- (NSFetchRequest *)requestWithEntityName:(NSString *)name
                                predicate:(nullable NSPredicate *)predicate
                           sortDescriptor:(nullable NSArray *)sortDescriptors;

/**
 获取CoreDate查询请求对象
 
 @param entity 实体描述对象
 @param predicate 筛选谓词
 @param sortDescriptors 排序数组@[NSSortDescriptor]
 @return FetchRequest实例
 */
- (NSFetchRequest *)requestWithEntity:(NSEntityDescription *)entity
                            predicate:(nullable NSPredicate *)predicate
                       sortDescriptor:(nullable NSArray *)sortDescriptors;


/**
 查询结果
 
 @param request 查询请求对象
 @return 结果集数组@[NSManagedObject]，查询异常返回nil
 */
- (NSArray *)resultsForRequest:(NSFetchRequest *)request;

/**
 查询结果集个数
 
 @param request 查询请求对象
 @return 结果集个数，查询异常时返回 0
 */
- (NSInteger)countForRequest:(NSFetchRequest *)request;
@end
NS_ASSUME_NONNULL_END

//MARK: - 重命名
typedef MTCoreDataManager CDManager;
