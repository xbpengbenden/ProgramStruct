//
//  JsonDataCache.h
//  ProgramStruct
//
//  Created by 神一样的电脑二 on 2016/12/14.
//  Copyright © 2016年 神一样的电脑二. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JsonDataCacheConfig;

#if OS_OBJECT_USE_OBJC
#undef JDDispatchQueueRelease
#undef JDDispatchQueueSetterSementics
#define JDDispatchQueueRelease(q)
#define JDDispatchQueueSetterSementics strong
#else
#undef JDDispatchQueueRelease
#undef JDDispatchQueueSetterSementics
#define JDDispatchQueueRelease(q) (dispatch_release(q))
#define JDDispatchQueueSetterSementics assign
#endif

typedef NS_ENUM(NSInteger, JsonDataCacheType) {
    /**
     * The json-data wasn't available the JSONDATA caches, but was downloaded from the web.
     */
    JsonDataCacheTypeNone,
    /**
     * The json-data was obtained from the disk cache.
     */
    JsonDataCacheTypeDisk,
    /**
     * The json-data was obtained from the memory cache.
     */
    JsonDataCacheTypeMemory
};

typedef void(^JsonDataCacheQueryCompletedBlock)(NSData * _Nullable data, JsonDataCacheType cacheType);

typedef void(^JsonDataCheckCacheCompletionBlock)(BOOL isInCache);

typedef void(^JsonDataCalculateSizeBlock)(NSUInteger fileCount, NSUInteger totalSize);

typedef void(^JsonDataNoParamsBlock)();


/**
 * JsonDataCache maintains a memory cache and an optional disk cache. Disk cache write operations are performed
 * asynchronous so it doesn’t add unnecessary latency to the UI.
 */
@interface JsonDataCache : NSObject

#pragma mark - Properties

/**
 *  Cache Config object - storing all kind of settings
 */
@property (nonatomic, nonnull, readonly) JsonDataCacheConfig *config;

/**
 * The maximum "total cost" of the in-memory image cache. The cost function is the number of pixels held in memory.
 */
@property (assign, nonatomic) NSUInteger maxMemoryCost;

/**
 * The maximum number of objects the cache should hold.
 */
@property (assign, nonatomic) NSUInteger maxMemoryCountLimit;

#pragma mark - Singleton and initialization

/**
 * Returns global shared cache instance
 *
 * @return JsonDataCache global instance
 */
+ (nonnull instancetype)sharedJsonDataCache;

/**
 * Init a new cache store with a specific namespace
 *
 * @param ns The namespace to use for this cache store
 */
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns;

/**
 * Init a new cache store with a specific namespace and directory
 *
 * @param ns        The namespace to use for this cache store
 * @param directory Directory to cache disk images in
 */
- (nonnull instancetype)initWithNamespace:(nonnull NSString *)ns
                       diskCacheDirectory:(nonnull NSString *)directory NS_DESIGNATED_INITIALIZER;

#pragma mark - Cache paths

- (nullable NSString *)makeDiskCachePath:(nonnull NSString*)fullNamespace;

/**
 * Add a read-only cache path to search for json-data pre-cached by JsonDataCache
 * Useful if you want to bundle pre-loaded images with your app
 *
 * @param path The path to use for this read-only cache path
 */
- (void)addReadOnlyCachePath:(nonnull NSString *)path;

#pragma mark - Store Ops

/**
 * Asynchronously store an json-data into memory and disk cache at the given key.
 *
 * @param json_data           The json nsdata to store
 * @param key             The unique json-data cache key, usually it's json-data absolute URL
 * @param completionBlock A block executed after the operation is finished
 */
- (void)storeJsonData:(nullable NSData *)json_data
            forKey:(nullable NSString *)key
        completion:(nullable JsonDataNoParamsBlock)completionBlock;

/**
 * Asynchronously store an json-data into memory and disk cache at the given key.
 *
 * @param json_data           The json nsdata to store
 * @param key             The unique json-data cache key, usually it's json-data absolute URL
 * @param toDisk          Store the json-data to disk cache if YES
 * @param completionBlock A block executed after the operation is finished
 */
- (void)storeJsonData:(nullable NSData *)json_data
            forKey:(nullable NSString *)key
            toDisk:(BOOL)toDisk
        completion:(nullable JsonDataNoParamsBlock)completionBlock;


/**
 * Synchronously store image NSData into disk cache at the given key.
 *
 * @warning This method is synchronous, make sure to call it from the ioQueue
 *
 * @param json_data  The json-data data to store
 * @param key        The unique json-data cache key, usually it's image absolute URL
 */
- (void)storeJsonDataToDisk:(nullable NSData *)json_data forKey:(nullable NSString *)key;

#pragma mark - Query and Retrieve Ops

/**
 *  Async check if json-data exists in disk cache already (does not load the json-data)
 *
 *  @param key             the key describing the url
 *  @param completionBlock the block to be executed when the check is done.
 *  @note the completion block will be always executed on the main queue
 */
- (void)diskJsonDataExistsWithKey:(nullable NSString *)key completion:(nullable JsonDataCheckCacheCompletionBlock)completionBlock;

/**
 * Operation that queries the cache asynchronously and call the completion when done.
 *
 * @param key       The unique key used to store the wanted json-data
 * @param doneBlock The completion block. Will not get called if the operation is cancelled
 *
 * @return a NSOperation instance containing the cache op
 */
- (nullable NSOperation *)queryCacheOperationForKey:(nullable NSString *)key done:(nullable JsonDataCacheQueryCompletedBlock)doneBlock;

/**
 * Query the memory cache synchronously.
 *
 * @param key The unique key used to store the json-data
 */
- (nullable NSData *)jsonDataFromMemoryCacheForKey:(nullable NSString *)key;

/**
 * Query the disk cache synchronously.
 *
 * @param key The unique key used to store the json-data
 */
- (nullable NSData *)jsonDataFromDiskCacheForKey:(nullable NSString *)key;

/**
 * Query the cache (memory and or disk) synchronously after checking the memory cache.
 *
 * @param key The unique key used to store the image
 */
- (nullable NSData *)jsonDataFromCacheForKey:(nullable NSString *)key;

#pragma mark - Remove Ops

/**
 * Remove the json-data from memory and disk cache asynchronously
 *
 * @param key             The unique json-data cache key
 * @param completion      A block that should be executed after the json-data has been removed (optional)
 */
- (void)removeJsonDataForKey:(nullable NSString *)key withCompletion:(nullable JsonDataNoParamsBlock)completion;

/**
 * Remove the json-data from memory and optionally disk cache asynchronously
 *
 * @param key             The unique json-data cache key
 * @param fromDisk        Also remove cache entry from disk if YES
 * @param completion      A block that should be executed after the json-data has been removed (optional)
 */
- (void)removeJsonDataForKey:(nullable NSString *)key fromDisk:(BOOL)fromDisk withCompletion:(nullable JsonDataNoParamsBlock)completion;

#pragma mark - Cache clean Ops

/**
 * Clear all memory cached images
 */
- (void)clearMemory;

/**
 * Async clear all disk cached json-data. Non-blocking method - returns immediately.
 * @param completion    A block that should be executed after cache expiration completes (optional)
 */
- (void)clearDiskOnCompletion:(nullable JsonDataNoParamsBlock)completion;

/**
 * Async remove all expired cached json-data from disk. Non-blocking method - returns immediately.
 * @param completionBlock A block that should be executed after cache expiration completes (optional)
 */
- (void)deleteOldFilesWithCompletionBlock:(nullable JsonDataNoParamsBlock)completionBlock;

#pragma mark - Cache Info

/**
 * Get the size used by the disk cache
 */
- (NSUInteger)getSize;

/**
 * Get the number of images in the disk cache
 */
- (NSUInteger)getDiskCount;

/**
 * Asynchronously calculate the disk cache's size.
 */
- (void)calculateSizeWithCompletionBlock:(nullable JsonDataCalculateSizeBlock)completionBlock;

#pragma mark - Cache Paths

/**
 *  Get the cache path for a certain key (needs the cache path root folder)
 *
 *  @param key  the key (can be obtained from url using cacheKeyForURL)
 *  @param path the cache path root folder
 *
 *  @return the cache path
 */
- (nullable NSString *)cachePathForKey:(nullable NSString *)key inPath:(nonnull NSString *)path;

/**
 *  Get the default cache path for a certain key
 *
 *  @param key the key (can be obtained from url using cacheKeyForURL)
 *
 *  @return the default cache path
 */
- (nullable NSString *)defaultCachePathForKey:(nullable NSString *)key;

@end

