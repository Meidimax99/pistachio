/* Automatically generated, don't edit */
/* Generated on: myoga */
/* At: Thu, 16 May 2024 07:44:51 +0000 */
/* Linux version 6.8.7-1-default (geeko@buildhost) (gcc (SUSE Linux) 13.2.1 20240206 [revision 67ac78caf31f7cb3202177e6428a46d829b70f23], GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.42.0.20240130-2) #1 SMP PREEMPT_DYNAMIC Thu Apr 18 07:12:38 UTC 2024 (5c0cf23) */

/* Pistachio Kernel Configuration System */

/* Hardware */

/* Basic Architecture */
#define CONFIG_ARCH_X86 1
#undef  CONFIG_ARCH_POWERPC
#undef  CONFIG_ARCH_POWERPC64


/* X86 Processor Architecture */
#undef  CONFIG_SUBARCH_X32
#define CONFIG_SUBARCH_X64 1


/* Processor Type */
#undef  CONFIG_CPU_X86_I486
#undef  CONFIG_CPU_X86_I586
#undef  CONFIG_CPU_X86_I686
#define CONFIG_CPU_X86_P4 1
#undef  CONFIG_CPU_X86_K8
#undef  CONFIG_CPU_X86_C3
#undef  CONFIG_CPU_X86_SIMICS


/* Platform */
#define CONFIG_PLAT_PC99 1


/* Miscellaneous */
#undef  CONFIG_IOAPIC

#undef  CONFIG_SMP


/* Kernel */
#undef  CONFIG_EXPERIMENTAL
#undef  CONFIG_IPC_FASTPATH
#define CONFIG_DEBUG 1
#undef  CONFIG_DEBUG_SYMBOLS
#undef  CONFIG_PERFMON
#undef  CONFIG_SPIN_WHEELS
#undef  CONFIG_NEW_MDB
#undef  CONFIG_STATIC_TCBS
#undef  CONFIG_X86_COMPATIBILITY_MODE


/* Debugger */

/* Kernel Debugger Console */
#define CONFIG_KDB_CONS_COM 1
#define CONFIG_KDB_COMPORT 0x0
#define CONFIG_KDB_COMSPEED 115200
#undef  CONFIG_KDB_CONS_KBD
#define CONFIG_KDB_BOOT_CONS 0

#undef  CONFIG_KDB_DISAS
#undef  CONFIG_KDB_ON_STARTUP
#undef  CONFIG_KDB_BREAKIN
#undef  CONFIG_KDB_INPUT_HLT
#undef  CONFIG_KDB_NO_ASSERTS

/* Trace Settings */
#undef  CONFIG_VERBOSE_INIT
#undef  CONFIG_TRACEPOINTS
#undef  CONFIG_KMEM_TRACE
#undef  CONFIG_TRACEBUFFER



/* Code Generator Options */


/* Derived symbols */
#undef  CONFIG_HAVE_MEMORY_CONTROL
#define CONFIG_X86_PSE 1
#undef  CONFIG_BIGENDIAN
#undef  CONFIG_PPC_MMU_TLB
#define CONFIG_X86_SYSENTER 1
#define CONFIG_X86_PGE 1
#define CONFIG_X86_FXSR 1
#undef  CONFIG_IS_32BIT
#define CONFIG_X86_HTT 1
#define CONFIG_X86_PAT 1
#undef  CONFIG_PPC_BOOKE
#define CONFIG_IS_64BIT 1
#undef  CONFIG_MULTI_ARCHITECTURE
#define CONFIG_X86_EM64T 1
#undef  CONFIG_PPC_CACHE_L1_WRITETHROUGH
#undef  CONFIG_PPC_TLB_INV_LOCAL
#undef  CONFIG_PPC_CACHE_ICBI_LOCAL
#undef  CONFIG_X86_SMALL_SPACES_GLOBAL
#define CONFIG_X86_HVM 1
#undef  CONFIG_PPC_MMU_SEGMENTS
#define CONFIG_X86_TSC 1
/* That's all, folks! */
#define AUTOCONF_INCLUDED
