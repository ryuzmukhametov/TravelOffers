//
//  OfferServiceImplementation.m
//  TravelOffers
//
//  Created by ryuzmukhametov on 15/10/16.
//  Copyright © 2016 Rustam Yuzmukhametov. All rights reserved.
//

#import "OfferPersistenceServiceImplementation.h"

#import "OfferModelObject.h"
#import "OfferNetworkService.h"
#import "OfferPlainObject.h"

@interface OfferPersistenceServiceImplementation ()

@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end


@implementation OfferPersistenceServiceImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error = nil;
        NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"TravelOffers.sqlite"];
        
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil
                                                            URL:storeURL
                                                        options:options error:&error];
        
        _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        _managedObjectContext.undoManager = nil;

    }
    return self;
}


#pragma mark - OfferPersistenceService
- (NSArray<OfferPlainObject*> *)fetchTrainOffers {
    return [self fetchPlainOffersUsingTravelMode:TravelModeTrain];
}

- (NSArray<OfferPlainObject*> *)fetchBusOffers {
    return [self fetchPlainOffersUsingTravelMode:TravelModeBus];
}

- (NSArray<OfferPlainObject*> *)fetchFlightOffers {
    return [self fetchPlainOffersUsingTravelMode:TravelModeFlight];
}

- (void)refreshTrainOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block {
    __weak typeof(self) welf = self;
    [self.offerNetworkService refreshTrainOffersWithCompletionBlock:^(NSArray *jsonArr, NSError *error) {
        [welf processRefreshResultWithTravelMode:TravelModeTrain jsonArr:jsonArr error:error block:block];
    }];
}


- (void)refreshBusOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block {
    __weak typeof(self) welf = self;
    [self.offerNetworkService refreshBusOffersWithCompletionBlock:^(NSArray *jsonArr, NSError *error) {
        [welf processRefreshResultWithTravelMode:TravelModeBus jsonArr:jsonArr error:error block:block];
    }];
    
}

- (void)refreshFlightOffersWithCompletionBlock:(RefreshOffersCompletionBlock)block {
    __weak typeof(self) welf = self;
    [self.offerNetworkService refreshFlightOffersWithCompletionBlock:^(NSArray *jsonArr, NSError *error) {
        [welf processRefreshResultWithTravelMode:TravelModeFlight jsonArr:jsonArr error:error block:block];
    }];
    
}

#pragma mark - Private
- (NSArray *)fetchManagedOffersUsingTravelMode:(TravelMode)travelMode {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(mode = %ld)", (long)travelMode];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Offer"];
    [fetchRequest setPredicate:predicate];
    NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:@"departureTime"
                                                               ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDesc]];
    NSError *error;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error) {
        // TODO:
    }
    return results;
}

- (NSArray *)fetchPlainOffersUsingTravelMode:(TravelMode)travelMode {
    NSArray *results = [self fetchManagedOffersUsingTravelMode:travelMode];
    return [self convertArrayOfManagerObjects:results];
}



- (void)deleteAllRecordsUsingTravelMode:(TravelMode)travelMode {
    NSArray *offers = [self fetchManagedOffersUsingTravelMode:travelMode];
    
    for (NSManagedObject *offer in offers) {
        [self.managedObjectContext deleteObject:offer];
    }
    NSError *saveError = nil;
    [self.managedObjectContext save:&saveError];
    if (saveError) {
        //DDLogError
    }
}

- (void)insertJsonArr:(NSArray*)jsonArr usingTravelMode:(TravelMode)travelMode {
    [self deleteAllRecordsUsingTravelMode:travelMode];
    for (NSDictionary *jsonDict in jsonArr) {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Offer"
                                                             inManagedObjectContext:self.managedObjectContext];
        OfferModelObject *offer = (OfferModelObject *)[[NSManagedObject alloc] initWithEntity:entityDescription
                                                               insertIntoManagedObjectContext:self.managedObjectContext];
        
        offer.arrivalTime = jsonDict[@"arrival_time"];
        offer.departureTime = jsonDict[@"departure_time"];
        offer.offerId = jsonDict[@"id"];
        offer.mode = @(travelMode);
        offer.numberOfStops = jsonDict[@"number_of_stops"];
        offer.priceInEuros = [self desiredNSNumberFromValue:jsonDict[@"price_in_euros"]];
        offer.providerLogo = jsonDict[@"provider_logo"];
    }
    
    [self.managedObjectContext save:NULL];
}

- (NSNumber*)desiredNSNumberFromValue:(id)value {
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    } else if ([value isKindOfClass:[NSString class]]) {
        double doubleVal = [value doubleValue];
        return [NSNumber numberWithDouble:doubleVal];
    } else {
        return nil;
    }
}

- (void)processRefreshResultWithTravelMode:(TravelMode)travelMode jsonArr:(NSArray*)jsonArr error:(NSError*)error block:(RefreshOffersCompletionBlock)block {
    if (error) {
        if (block) {
            block(error);
        }
    } else {
        [self insertJsonArr:jsonArr usingTravelMode:travelMode];
        if (block) {
            block(nil);
        }
    }
}

- (OfferPlainObject*)convertManagerObject:(OfferModelObject*)offerModelObject {
    OfferPlainObject *offerPlainObject = [[OfferPlainObject alloc] init];
    offerPlainObject.arrivalTime = offerModelObject.arrivalTime;
    offerPlainObject.departureTime = offerModelObject.departureTime;
    offerPlainObject.offerId = offerModelObject.offerId;
    offerPlainObject.mode = offerModelObject.mode;
    offerPlainObject.numberOfStops = offerModelObject.numberOfStops;
    offerPlainObject.priceInEuros = offerModelObject.priceInEuros;
    offerPlainObject.providerLogo = offerModelObject.providerLogo;
    return offerPlainObject;
}

- (NSArray*)convertArrayOfManagerObjects:(NSArray*)arrayOfManagedObjects {
    NSMutableArray *arrayOfPlainObjects = [[NSMutableArray alloc] init];
    for (OfferModelObject *offerModelObject in arrayOfManagedObjects) {
        OfferPlainObject *offerPlainObject = [self convertManagerObject:offerModelObject];
        [arrayOfPlainObjects addObject:offerPlainObject];
    }
    return arrayOfPlainObjects;
}

@end
