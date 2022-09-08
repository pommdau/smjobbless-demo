//
//  NSXPCConnection+AuditToken.h
//  SMJobBlessDemo
//
//  Created by HIROKI IKEUCHI on 2022/09/08.
//

@import Foundation;

@interface NSXPCConnection (AuditToken)

// Apple uses this property internally to verify XPC connections.
// There is no safe pulicly available alternative (check by client pid, for example, is racy)
@property (nonatomic, readonly) audit_token_t auditToken;

@end
