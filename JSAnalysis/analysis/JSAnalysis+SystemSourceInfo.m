//
//  JSAnalysis+SystemSourceInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis+SystemSourceInfo.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <assert.h>
#import <sys/types.h>
#import <sys/sysctl.h>
#import <objc/runtime.h>
#import <sys/mount.h>



@implementation JSAnalysis (SystemSourceInfo)

+ (float)getAppCpuUsage {
    kern_return_t           kr;
    thread_array_t          thread_list;
    mach_msg_type_number_t  thread_count;
    thread_info_data_t      thinfo;
    mach_msg_type_number_t  thread_info_count;
    thread_basic_info_t     basic_info_th;
    
    kr = task_threads(mach_task_self(), &thread_list, &thread_count);
    if (kr != KERN_SUCCESS) {
        return -1.0;
    }
    
    float cpu_usage = 0;
    
    for (int i = 0; i < thread_count; i++)
    {
        thread_info_count = THREAD_INFO_MAX;
        kr = thread_info(thread_list[i], THREAD_BASIC_INFO,(thread_info_t)thinfo, &thread_info_count);
        if (kr != KERN_SUCCESS) {
            return -1.0;
        }
        
        basic_info_th = (thread_basic_info_t)thinfo;
        
        if (!(basic_info_th->flags & TH_FLAGS_IDLE))
        {
            cpu_usage += basic_info_th->cpu_usage;
        }
    }
    
    cpu_usage = cpu_usage / (float)TH_USAGE_SCALE * 100.0;
    
    vm_deallocate(mach_task_self(), (vm_offset_t)thread_list, thread_count * sizeof(thread_t));
    return cpu_usage;
}

+ (float)getCpuUsage {
    kern_return_t kr;
    mach_msg_type_number_t count;
    static host_cpu_load_info_data_t previous_info = {0, 0, 0, 0};
    host_cpu_load_info_data_t info;
    
    count = HOST_CPU_LOAD_INFO_COUNT;
    
    
    
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (host_info_t)&info, &count);
    if (kr != KERN_SUCCESS) {
        return -1.0;
    }
    
    natural_t user   = info.cpu_ticks[CPU_STATE_USER] - previous_info.cpu_ticks[CPU_STATE_USER];
    natural_t nice   = info.cpu_ticks[CPU_STATE_NICE] - previous_info.cpu_ticks[CPU_STATE_NICE];
    natural_t system = info.cpu_ticks[CPU_STATE_SYSTEM] - previous_info.cpu_ticks[CPU_STATE_SYSTEM];
    natural_t idle   = info.cpu_ticks[CPU_STATE_IDLE] - previous_info.cpu_ticks[CPU_STATE_IDLE];
    natural_t total  = user + nice + system + idle;
    previous_info    = info;
    
    
    return (user + nice + system) * 100.0 / total;
}

+ (unsigned long long)getPhysicalMemory {
    return [NSProcessInfo processInfo].physicalMemory;
}

+ (unsigned long long)getAppUsedMemory {
    int64_t usage = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kr = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    
    if(kr != KERN_SUCCESS) {
        return -1;
    }
    
    usage = (int64_t) vmInfo.phys_footprint;
    
    return usage;
}

+ (int64_t)getUsedMemory {
    size_t length = 0;
    int mib[6] = {0};
    
    int pagesize = 0;
    mib[0] = CTL_HW;
    mib[1] = HW_PAGESIZE;
    length = sizeof(pagesize);
    if (sysctl(mib, 2, &pagesize, &length, NULL, 0) < 0) {
        return 0;
    }
    
    mach_msg_type_number_t count = HOST_VM_INFO_COUNT;
    
    vm_statistics_data_t vmstat;
    
    if (host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmstat, &count) != KERN_SUCCESS) {
        return 0;
    }
    
    int wireMem = vmstat.wire_count * pagesize;
    int activeMem = vmstat.active_count * pagesize;
    return wireMem + activeMem;
}

+ (NSString *)getKernelVersion {
    kern_return_t kr;
    kernel_version_t kernel_v;
    kr = host_kernel_version(mach_host_self(),kernel_v);
    return [NSString stringWithUTF8String:kernel_v];
}

#pragma mark -- 总存储空间大小
+ (unsigned long long)getTotalSpace {
    struct statfs buffer;
    unsigned long long maxspace = 0;
    
    if (0 <= statfs("/", &buffer)) {
        maxspace = (unsigned long long)buffer.f_bsize * buffer.f_blocks;
    }
    
    if (0 <= statfs("/private/var", &buffer)) {
        maxspace += (unsigned long long)buffer.f_bsize * buffer.f_blocks;
    }
    return maxspace;
}

+ (unsigned long long)getFreeSpace {
    struct statfs buffer;
    long long freespace = 0;
    if(0 <= statfs("/var", &buffer)) {
        freespace = (unsigned long long)(buffer.f_bsize * buffer.f_bfree);
    }
    return freespace;
}

@end
