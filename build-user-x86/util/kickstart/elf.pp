# 0 "../../../user/util/kickstart/elf.cc"
# 1 "/home/max/code/ba/pistachio_2/build-user-x86/util/kickstart//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "../../../user/util/kickstart/elf.cc"
# 32 "../../../user/util/kickstart/elf.cc"
# 1 "../../config.h" 1
# 33 "../../../user/util/kickstart/elf.cc" 2
# 1 "../../../user/include/l4io.h" 1
# 35 "../../../user/include/l4io.h"
# 1 "../../../user/include/l4/types.h" 1
# 65 "../../../user/include/l4/types.h"
# 1 "../../../user/include/l4/amd64/types.h" 1
# 41 "../../../user/include/l4/amd64/types.h"
typedef unsigned long L4_Word64_t;
typedef unsigned int L4_Word32_t;
typedef unsigned short L4_Word16_t;
typedef unsigned char L4_Word8_t;

typedef unsigned long L4_Word_t;

typedef signed long L4_SignedWord64_t;
typedef signed int L4_SignedWord32_t;
typedef signed short L4_SignedWord16_t;
typedef signed char L4_SignedWord8_t;

typedef signed long L4_SignedWord_t;

typedef unsigned long L4_Size_t;
typedef L4_Word64_t L4_Paddr_t;
# 66 "../../../user/include/l4/types.h" 2
# 77 "../../../user/include/l4/types.h"
typedef L4_Word_t L4_Bool_t;
# 147 "../../../user/include/l4/types.h"
typedef union {
    L4_Word_t raw;
    struct {
 L4_Word_t rwx : 3; L4_Word_t extended : 1; L4_Word_t s : 6; L4_Word_t b : 22 + (sizeof (L4_Word_t) * 8 - 32)



                  ;
    } X;
} L4_Fpage_t;
# 169 "../../../user/include/l4/types.h"
# 1 "../../../user/include/l4/amd64/specials.h" 1
# 38 "../../../user/include/l4/amd64/specials.h"
static inline void __L4_Inc_Atomic (L4_Word_t *w)
{
    __asm__ __volatile__(
        "/* l4_inc_atomic()	*/\n"
        "lock; add $1, %0"
        : "=m"(w));
}


static inline int __L4_Msb (L4_Word_t w) __attribute__ ((const));

static inline int __L4_Msb (L4_Word_t w)
{
    L4_Word_t bitnum;

    __asm__ (
 "/* l4_msb()		*/			\n"
 "bsrq	%1, %0					\n"
 :
 "=r" (bitnum)
 :
 "rm" (w)
 );

    return bitnum;
}





static inline int __L4_Lsb (L4_Word_t w) __attribute__ ((const));

static inline int __L4_Lsb (L4_Word_t w)
{
    L4_Word_t bitnum;

    __asm__ (
 "/* l4_lsb()		*/			\n"
 "bsf	%1, %0					\n"
 :
 "=r" (bitnum)
 :
 "rm" (w)
 );

    return bitnum;
}

static inline L4_Word64_t __L4_Rdtsc ()
{
    L4_Word_t eax, edx;

    __asm__ __volatile__ (
 "/* l4_rdtsc()		*/			\n"
        "rdtsc"
        : "=a"(eax), "=d"(edx));

    return (((L4_Word64_t)edx) << 32) | (L4_Word64_t)eax;
}

static inline L4_Word64_t __L4_Rdpmc (const L4_Word_t ctrsel)
{
    L4_Word_t eax, edx;

    __asm__ __volatile__ (
 "/* l4_rdpmc()		*/			\n"
        "rdpmc"
        : "=a"(eax), "=d"(edx)
        : "c"(ctrsel));

    return (((L4_Word64_t)edx) << 32) | (L4_Word64_t)eax;
}
# 170 "../../../user/include/l4/types.h" 2

static inline L4_Bool_t L4_IsNilFpage (L4_Fpage_t f)
{
    return f.raw == 0;
}

static inline L4_Word_t L4_Rights (L4_Fpage_t f)
{
    return f.X.rwx;
}

static inline L4_Fpage_t L4_Set_Rights (L4_Fpage_t * f, L4_Word_t rwx)
{
    f->X.rwx = rwx;
    return *f;
}

static inline L4_Fpage_t L4_FpageAddRights (L4_Fpage_t f, L4_Word_t rwx)
{
    f.X.rwx |= rwx;
    return f;
}

static inline L4_Fpage_t L4_FpageAddRightsTo (L4_Fpage_t * f, L4_Word_t rwx)
{
    f->X.rwx |= rwx;
    return *f;
}

static inline L4_Fpage_t L4_FpageRemoveRights (L4_Fpage_t f, L4_Word_t rwx)
{
    f.X.rwx &= ~rwx;
    return f;
}

static inline L4_Fpage_t L4_FpageRemoveRightsFrom (L4_Fpage_t * f, L4_Word_t rwx)
{
    f->X.rwx &= ~rwx;
    return *f;
}


static inline L4_Fpage_t operator + (const L4_Fpage_t & f, L4_Word_t rwx)
{
    return L4_FpageAddRights (f, rwx);
}

static inline L4_Fpage_t operator += (L4_Fpage_t & f, L4_Word_t rwx)
{
    return L4_FpageAddRightsTo (&f, rwx);
}

static inline L4_Fpage_t operator - (const L4_Fpage_t & f, L4_Word_t rwx)
{
    return L4_FpageRemoveRights (f, rwx);
}

static inline L4_Fpage_t operator -= (L4_Fpage_t & f, L4_Word_t rwx)
{
    return L4_FpageRemoveRightsFrom (&f, rwx);
}


static inline L4_Fpage_t L4_Fpage (L4_Word_t BaseAddress, L4_Word_t FpageSize)
{
    L4_Fpage_t fp;
    L4_Word_t msb = __L4_Msb (FpageSize);
    fp.raw = BaseAddress;
    fp.X.s = (1UL << msb) < FpageSize ? msb + 1 : msb;
    fp.X.rwx = (0x00);
    return fp;
}

static inline L4_Fpage_t L4_FpageLog2 (L4_Word_t BaseAddress, int FpageSize)
{
    L4_Fpage_t fp;
    fp.raw = BaseAddress;
    fp.X.s = FpageSize;
    fp.X.rwx = (0x00);
    return fp;
}

static inline L4_Word_t L4_Address (L4_Fpage_t f)
{
    return f.raw & ~((1UL << f.X.s) - 1);
}

static inline L4_Word_t L4_Size (L4_Fpage_t f)
{
    return f.X.s == 0 ? 0 : (1UL << f.X.s);
}

static inline L4_Word_t L4_SizeLog2 (L4_Fpage_t f)
{
    return f.X.s;
}






typedef union {
    L4_Word_t raw;
    struct {
 L4_Word_t version : 32; L4_Word_t thread_no : 32

                   ;
    } X;
} L4_GthreadId_t;

typedef union {
    L4_Word_t raw;
    struct {
 L4_Word_t __zeros : 6; L4_Word_t local_id : 26 + (sizeof (L4_Word_t) * 8 - 32)

                         ;
    } X;
} L4_LthreadId_t;

typedef union {
    L4_Word_t raw;
    L4_GthreadId_t global;
    L4_LthreadId_t local;
} L4_ThreadId_t;





static inline L4_ThreadId_t L4_GlobalId (L4_Word_t threadno, L4_Word_t version)
{
    L4_ThreadId_t t;
    t.global.X.thread_no = threadno;
    t.global.X.version = version;
    return t;
}

static inline L4_Word_t L4_Version (L4_ThreadId_t t)
{
    return t.global.X.version;
}

static inline L4_Word_t L4_ThreadNo (L4_ThreadId_t t)
{
    return t.global.X.thread_no;
}

static inline L4_Bool_t L4_IsThreadEqual (const L4_ThreadId_t l,
          const L4_ThreadId_t r)
{
    return l.raw == r.raw;
}

static inline L4_Bool_t L4_IsThreadNotEqual (const L4_ThreadId_t l,
      const L4_ThreadId_t r)
{
    return l.raw != r.raw;
}


static inline L4_Bool_t operator == (const L4_ThreadId_t & l,
         const L4_ThreadId_t & r)
{
    return l.raw == r.raw;
}

static inline L4_Bool_t operator != (const L4_ThreadId_t & l,
         const L4_ThreadId_t & r)
{
    return l.raw != r.raw;
}


static inline L4_Bool_t L4_IsNilThread (L4_ThreadId_t t)
{
    return t.raw == 0;
}

static inline L4_Bool_t L4_IsLocalId (L4_ThreadId_t t)
{
    return t.local.X.__zeros == 0;
}

static inline L4_Bool_t L4_IsGlobalId (L4_ThreadId_t t)
{
    return t.local.X.__zeros != 0;
}







typedef union {
    L4_Word64_t raw;
    struct {
 L4_Word32_t low;
 L4_Word32_t high;
    } X;
} L4_Clock_t;


static inline L4_Clock_t operator + (const L4_Clock_t & l, const int r)
{
    return (L4_Clock_t) { raw : l.raw + r };
}

static inline L4_Clock_t operator + (const L4_Clock_t & l, const L4_Word64_t r)
{
    return (L4_Clock_t) { raw : l.raw + r };
}

static inline L4_Clock_t operator + (const L4_Clock_t & l, const L4_Clock_t r)
{
    return (L4_Clock_t) { raw : l.raw + r.raw };
}

static inline L4_Clock_t operator - (const L4_Clock_t & l, const int r)
{
    return (L4_Clock_t) { raw : l.raw - r };
}

static inline L4_Clock_t operator - (const L4_Clock_t & l, const L4_Word64_t r)
{
    return (L4_Clock_t) { raw : l.raw - r };
}

static inline L4_Clock_t operator - (const L4_Clock_t & l, const L4_Clock_t r)
{
    return (L4_Clock_t) { raw : l.raw - r.raw };
}


static inline L4_Clock_t L4_ClockAddUsec (const L4_Clock_t c, const L4_Word64_t r)
{
    return (L4_Clock_t) { raw : c.raw + r };
}

static inline L4_Clock_t L4_ClockSubUsec (const L4_Clock_t c, const L4_Word64_t r)
{
    return (L4_Clock_t) { raw : c.raw - r };
}


static inline L4_Bool_t operator < (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw < r.raw;
}

static inline L4_Bool_t operator > (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw > r.raw;
}

static inline L4_Bool_t operator <= (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw <= r.raw;
}

static inline L4_Bool_t operator >= (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw >= r.raw;
}

static inline L4_Bool_t operator == (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw == r.raw;
}

static inline L4_Bool_t operator != (const L4_Clock_t &l, const L4_Clock_t &r)
{
    return l.raw != r.raw;
}



static inline L4_Bool_t L4_IsClockEarlier (const L4_Clock_t l, const L4_Clock_t r)
{
    return l.raw < r.raw;
}

static inline L4_Bool_t L4_IsClockLater (const L4_Clock_t l, const L4_Clock_t r)
{
    return l.raw > r.raw;
}

static inline L4_Bool_t L4_IsClockEqual (const L4_Clock_t l, const L4_Clock_t r)
{
    return l.raw == r.raw;
}

static inline L4_Bool_t L4_IsClockNotEqual (const L4_Clock_t l, const L4_Clock_t r)
{
    return l.raw != r.raw;
}






typedef union {
    L4_Word16_t raw;
    struct {
 L4_Word_t m : 10; L4_Word_t e : 5; L4_Word_t a : 1


        ;
    } period;
    struct {
 L4_Word_t m : 10; L4_Word_t c : 1; L4_Word_t e : 4; L4_Word_t a : 1



        ;
    } point;
} L4_Time_t;




static inline L4_Time_t L4_TimePeriod (L4_Word64_t microseconds)
{






    L4_Time_t time;
    time.raw = 0;

    if (__builtin_constant_p (microseconds)) {
 if (0) {}
 else if (microseconds < (1UL << 10)) do { time.period.m = microseconds >> (10 - 10); time.period.e = 10 - 10; } while (0); else if (microseconds < (1UL << 11)) do { time.period.m = microseconds >> (11 - 10); time.period.e = 11 - 10; } while (0);
 else if (microseconds < (1UL << 12)) do { time.period.m = microseconds >> (12 - 10); time.period.e = 12 - 10; } while (0); else if (microseconds < (1UL << 13)) do { time.period.m = microseconds >> (13 - 10); time.period.e = 13 - 10; } while (0);
 else if (microseconds < (1UL << 14)) do { time.period.m = microseconds >> (14 - 10); time.period.e = 14 - 10; } while (0); else if (microseconds < (1UL << 15)) do { time.period.m = microseconds >> (15 - 10); time.period.e = 15 - 10; } while (0);
 else if (microseconds < (1UL << 16)) do { time.period.m = microseconds >> (16 - 10); time.period.e = 16 - 10; } while (0); else if (microseconds < (1UL << 17)) do { time.period.m = microseconds >> (17 - 10); time.period.e = 17 - 10; } while (0);
 else if (microseconds < (1UL << 18)) do { time.period.m = microseconds >> (18 - 10); time.period.e = 18 - 10; } while (0); else if (microseconds < (1UL << 19)) do { time.period.m = microseconds >> (19 - 10); time.period.e = 19 - 10; } while (0);
 else if (microseconds < (1UL << 20)) do { time.period.m = microseconds >> (20 - 10); time.period.e = 20 - 10; } while (0); else if (microseconds < (1UL << 21)) do { time.period.m = microseconds >> (21 - 10); time.period.e = 21 - 10; } while (0);
 else if (microseconds < (1UL << 22)) do { time.period.m = microseconds >> (22 - 10); time.period.e = 22 - 10; } while (0); else if (microseconds < (1UL << 23)) do { time.period.m = microseconds >> (23 - 10); time.period.e = 23 - 10; } while (0);
 else if (microseconds < (1UL << 24)) do { time.period.m = microseconds >> (24 - 10); time.period.e = 24 - 10; } while (0); else if (microseconds < (1UL << 25)) do { time.period.m = microseconds >> (25 - 10); time.period.e = 25 - 10; } while (0);
 else if (microseconds < (1UL << 26)) do { time.period.m = microseconds >> (26 - 10); time.period.e = 26 - 10; } while (0); else if (microseconds < (1UL << 27)) do { time.period.m = microseconds >> (27 - 10); time.period.e = 27 - 10; } while (0);
 else if (microseconds < (1UL << 28)) do { time.period.m = microseconds >> (28 - 10); time.period.e = 28 - 10; } while (0); else if (microseconds < (1UL << 29)) do { time.period.m = microseconds >> (29 - 10); time.period.e = 29 - 10; } while (0);
 else if (microseconds < (1UL << 30)) do { time.period.m = microseconds >> (30 - 10); time.period.e = 30 - 10; } while (0); else if (microseconds < (1UL << 31)) do { time.period.m = microseconds >> (31 - 10); time.period.e = 31 - 10; } while (0);
 else
     return ((L4_Time_t) { raw : 0UL });
    } else {
 L4_Word_t l4_exp = 0;
 L4_Word_t man = microseconds;
 while (man >= (1 << 10)) {
     man >>= 1;
     l4_exp++;
 }
 if (l4_exp <= 31)
     do { time.period.m = man; time.period.e = l4_exp; } while (0);
 else
     return ((L4_Time_t) { raw : 0UL });
    }

    return time;


}
# 36 "../../../user/include/l4io.h" 2

# 1 "/usr/lib64/gcc/x86_64-suse-linux/13/include/stdarg.h" 1
# 40 "/usr/lib64/gcc/x86_64-suse-linux/13/include/stdarg.h"
typedef __builtin_va_list __gnuc_va_list;
# 103 "/usr/lib64/gcc/x86_64-suse-linux/13/include/stdarg.h"
typedef __gnuc_va_list va_list;
# 38 "../../../user/include/l4io.h" 2


extern "C" {


int vsnprintf(char *str, L4_Size_t size, const char *fmt, va_list ap);
int snprintf(char *str, L4_Size_t size, const char *fmt, ...);
int printf(const char *fmt, ...);
void putc(int c);
int getc(void);



}
# 34 "../../../user/util/kickstart/elf.cc" 2

# 1 "../../../user/util/kickstart/kickstart.h" 1
# 45 "../../../user/util/kickstart/kickstart.h"
class loader_format_t
{
public:




    const char * name;





    bool (*probe)(void);





    L4_Word_t (*init)(void);
};







extern loader_format_t loader_formats[];




void launch_kernel (L4_Word_t entry);
void flush_cache (void);
void fail (int ec);





static inline L4_Word_t align_up (L4_Word_t addr, L4_Word_t size)
{
    return (addr + size - 1) & ~(size - 1);
}
# 36 "../../../user/util/kickstart/elf.cc" 2
# 1 "../../../user/util/kickstart/elf.h" 1
# 49 "../../../user/util/kickstart/elf.h"
# 1 "../../../user/util/kickstart/bootinfo.h" 1
# 35 "../../../user/util/kickstart/bootinfo.h"
# 1 "../../config.h" 1
# 36 "../../../user/util/kickstart/bootinfo.h" 2

# 1 "../../../user/util/kickstart/mbi.h" 1
# 45 "../../../user/util/kickstart/mbi.h"
class mbi_module_t {
public:
    L4_Word_t start;
    L4_Word_t end;
    char* cmdline;
    L4_Word_t entry;


};

class mbi_t {
public:
    struct {
        L4_Word_t mem :1; L4_Word_t bootdev :1; L4_Word_t cmdline :1; L4_Word_t mods :1; L4_Word_t syms :2; L4_Word_t mmap :1





                           ;
    } flags;


    L4_Word_t mem_lower;
    L4_Word_t mem_upper;


    L4_Word_t boot_device;


    char* cmdline;


    L4_Word_t modcount;
    mbi_module_t* mods;


    L4_Word_t syms[4];


    L4_Word_t mmap_length;
    L4_Word_t mmap_addr;

    L4_Word_t drives_length;
    L4_Word_t drives_addr;
    L4_Word_t config_table;
    L4_Word_t boot_loader_name;
    L4_Word_t apm_table;
    L4_Word_t vbe[4];


public:
    static mbi_t* prepare();

    L4_Word_t get_size();
    void copy( mbi_t *target );
    bool is_mem_region_free( L4_Word_t start, L4_Word_t size );
};





bool mbi_probe (void);
L4_Word_t mbi_init (void);
# 38 "../../../user/util/kickstart/bootinfo.h" 2





namespace BI32
{

typedef L4_Word32_t L4_Word_t;

# 1 "../../../user/include/l4/bootinfo.h" 1
# 69 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;
} L4_BootRec_t;

static inline L4_Word_t L4_BootRec_Type (const L4_BootRec_t * r)
{
    return r->type;
}

static inline L4_BootRec_t * L4_BootRec_Next (const L4_BootRec_t * r)
{
    return (L4_BootRec_t *) ((L4_Word8_t *) r + r->offset_next);
}


static inline L4_Word_t L4_Type (const L4_BootRec_t * r)
{
    return L4_BootRec_Type (r);
}

static inline L4_BootRec_t * L4_Next (const L4_BootRec_t * r)
{
    return L4_BootRec_Next (r);
}
# 105 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t start;
    L4_Word_t size;
    L4_Word_t cmdline_offset;
} L4_Boot_Module_t;

static inline L4_Word_t L4_Module_Start (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    return m->start;
}

static inline L4_Word_t L4_Module_Size (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    return m->size;
}

static inline char * L4_Module_Cmdline (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    if (m->cmdline_offset)
 return (char *) m + m->cmdline_offset;
    else
 return (char *) 0;
}
# 144 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t text_pstart;
    L4_Word_t text_vstart;
    L4_Word_t text_size;
    L4_Word_t data_pstart;
    L4_Word_t data_vstart;
    L4_Word_t data_size;
    L4_Word_t bss_pstart;
    L4_Word_t bss_vstart;
    L4_Word_t bss_size;
    L4_Word_t initial_ip;
    L4_Word_t flags;
    L4_Word_t label;
    L4_Word_t cmdline_offset;
} L4_Boot_SimpleExec_t;

static inline L4_Word_t L4_SimpleExec_TextVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_vstart;
}

static inline L4_Word_t L4_SimpleExec_TextPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_pstart;
}

static inline L4_Word_t L4_SimpleExec_TextSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_size;
}

static inline L4_Word_t L4_SimpleExec_DataVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_vstart;
}

static inline L4_Word_t L4_SimpleExec_DataPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_pstart;
}

static inline L4_Word_t L4_SimpleExec_DataSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_size;
}

static inline L4_Word_t L4_SimpleExec_BssVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_vstart;
}

static inline L4_Word_t L4_SimpleExec_BssPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_pstart;
}

static inline L4_Word_t L4_SimpleExec_BssSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_size;
}

static inline L4_Word_t L4_SimpleExec_InitialIP (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->initial_ip;
}

static inline L4_Word_t L4_SimpleExec_Flags (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->flags;
}

static inline void L4_SimpleExec_Set_Flags (const L4_BootRec_t * ptr, L4_Word_t w)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    e->flags = w;
}

static inline L4_Word_t L4_SimpleExec_Label (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->label;
}

static inline void L4_SimpleExec_Set_Label (const L4_BootRec_t * ptr, L4_Word_t w)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    e->label = w;
}

static inline char * L4_SimpleExec_Cmdline (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    if (e->cmdline_offset)
 return (char *) ((L4_Word8_t *) e + e->cmdline_offset);
    else
 return (char *) 0;
}
# 265 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t systab;
    L4_Word_t memmap;
    L4_Word_t memmap_size;
    L4_Word_t memdesc_size;
    L4_Word_t memdesc_version;
} L4_Boot_EFI_t;

static inline L4_Word_t L4_EFI_Systab (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->systab;
}

static inline L4_Word_t L4_EFI_Memmap (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memmap;
}

static inline L4_Word_t L4_EFI_MemmapSize (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memmap_size;
}

static inline L4_Word_t L4_EFI_MemdescSize (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memdesc_size;
}

static inline L4_Word_t L4_EFI_MemdescVersion (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memdesc_version;
}
# 314 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t address;
} L4_Boot_MBI_t;

static inline L4_Word_t L4_MBI_Address (const L4_BootRec_t * ptr)
{
    L4_Boot_MBI_t * m = (L4_Boot_MBI_t *) ptr;
    return m->address;
}





typedef struct {
    L4_Word_t magic;
    L4_Word_t version;
    L4_Word_t size;
    L4_Word_t first_entry;
    L4_Word_t num_entries;
    L4_Word_t __reserved[3];
} L4_BootInfo_t;

static inline L4_Bool_t L4_BootInfo_Valid (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return (b->magic == ((L4_Word_t) 0x14b0021d)) &&
 (b->version == 1);
}

static inline L4_Word_t L4_BootInfo_Size (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return b->size;
}

static inline L4_BootRec_t * L4_BootInfo_FirstEntry (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return (L4_BootRec_t *) ((L4_Word8_t *) b + b->first_entry);
}

static inline L4_Word_t L4_BootInfo_Entries (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return b->num_entries;
}
# 49 "../../../user/util/kickstart/bootinfo.h" 2


L4_BootRec_t * init_bootinfo (L4_BootInfo_t * bi);

L4_BootRec_t * record_bootinfo_modules (L4_BootInfo_t * bi,
     L4_BootRec_t * rec,
     mbi_t * mbi,
     mbi_module_t orig_mbi_modules[],
     unsigned int decode_count);

L4_BootRec_t * record_bootinfo_mbi (L4_BootInfo_t * bi,
        L4_BootRec_t * rec,
        mbi_t * mbi);

}

namespace BI64
{

typedef L4_Word64_t L4_Word_t;

# 1 "../../../user/include/l4/bootinfo.h" 1
# 69 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;
} L4_BootRec_t;

static inline L4_Word_t L4_BootRec_Type (const L4_BootRec_t * r)
{
    return r->type;
}

static inline L4_BootRec_t * L4_BootRec_Next (const L4_BootRec_t * r)
{
    return (L4_BootRec_t *) ((L4_Word8_t *) r + r->offset_next);
}


static inline L4_Word_t L4_Type (const L4_BootRec_t * r)
{
    return L4_BootRec_Type (r);
}

static inline L4_BootRec_t * L4_Next (const L4_BootRec_t * r)
{
    return L4_BootRec_Next (r);
}
# 105 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t start;
    L4_Word_t size;
    L4_Word_t cmdline_offset;
} L4_Boot_Module_t;

static inline L4_Word_t L4_Module_Start (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    return m->start;
}

static inline L4_Word_t L4_Module_Size (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    return m->size;
}

static inline char * L4_Module_Cmdline (const L4_BootRec_t * ptr)
{
    L4_Boot_Module_t * m = (L4_Boot_Module_t *) ptr;
    if (m->cmdline_offset)
 return (char *) m + m->cmdline_offset;
    else
 return (char *) 0;
}
# 144 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t text_pstart;
    L4_Word_t text_vstart;
    L4_Word_t text_size;
    L4_Word_t data_pstart;
    L4_Word_t data_vstart;
    L4_Word_t data_size;
    L4_Word_t bss_pstart;
    L4_Word_t bss_vstart;
    L4_Word_t bss_size;
    L4_Word_t initial_ip;
    L4_Word_t flags;
    L4_Word_t label;
    L4_Word_t cmdline_offset;
} L4_Boot_SimpleExec_t;

static inline L4_Word_t L4_SimpleExec_TextVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_vstart;
}

static inline L4_Word_t L4_SimpleExec_TextPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_pstart;
}

static inline L4_Word_t L4_SimpleExec_TextSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->text_size;
}

static inline L4_Word_t L4_SimpleExec_DataVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_vstart;
}

static inline L4_Word_t L4_SimpleExec_DataPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_pstart;
}

static inline L4_Word_t L4_SimpleExec_DataSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->data_size;
}

static inline L4_Word_t L4_SimpleExec_BssVstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_vstart;
}

static inline L4_Word_t L4_SimpleExec_BssPstart (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_pstart;
}

static inline L4_Word_t L4_SimpleExec_BssSize (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->bss_size;
}

static inline L4_Word_t L4_SimpleExec_InitialIP (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->initial_ip;
}

static inline L4_Word_t L4_SimpleExec_Flags (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->flags;
}

static inline void L4_SimpleExec_Set_Flags (const L4_BootRec_t * ptr, L4_Word_t w)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    e->flags = w;
}

static inline L4_Word_t L4_SimpleExec_Label (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    return e->label;
}

static inline void L4_SimpleExec_Set_Label (const L4_BootRec_t * ptr, L4_Word_t w)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    e->label = w;
}

static inline char * L4_SimpleExec_Cmdline (const L4_BootRec_t * ptr)
{
    L4_Boot_SimpleExec_t * e = (L4_Boot_SimpleExec_t *) ptr;
    if (e->cmdline_offset)
 return (char *) ((L4_Word8_t *) e + e->cmdline_offset);
    else
 return (char *) 0;
}
# 265 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t systab;
    L4_Word_t memmap;
    L4_Word_t memmap_size;
    L4_Word_t memdesc_size;
    L4_Word_t memdesc_version;
} L4_Boot_EFI_t;

static inline L4_Word_t L4_EFI_Systab (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->systab;
}

static inline L4_Word_t L4_EFI_Memmap (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memmap;
}

static inline L4_Word_t L4_EFI_MemmapSize (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memmap_size;
}

static inline L4_Word_t L4_EFI_MemdescSize (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memdesc_size;
}

static inline L4_Word_t L4_EFI_MemdescVersion (const L4_BootRec_t * ptr)
{
    L4_Boot_EFI_t * e = (L4_Boot_EFI_t *) ptr;
    return e->memdesc_version;
}
# 314 "../../../user/include/l4/bootinfo.h"
typedef struct {
    L4_Word_t type;
    L4_Word_t version;
    L4_Word_t offset_next;

    L4_Word_t address;
} L4_Boot_MBI_t;

static inline L4_Word_t L4_MBI_Address (const L4_BootRec_t * ptr)
{
    L4_Boot_MBI_t * m = (L4_Boot_MBI_t *) ptr;
    return m->address;
}





typedef struct {
    L4_Word_t magic;
    L4_Word_t version;
    L4_Word_t size;
    L4_Word_t first_entry;
    L4_Word_t num_entries;
    L4_Word_t __reserved[3];
} L4_BootInfo_t;

static inline L4_Bool_t L4_BootInfo_Valid (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return (b->magic == ((L4_Word_t) 0x14b0021d)) &&
 (b->version == 1);
}

static inline L4_Word_t L4_BootInfo_Size (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return b->size;
}

static inline L4_BootRec_t * L4_BootInfo_FirstEntry (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return (L4_BootRec_t *) ((L4_Word8_t *) b + b->first_entry);
}

static inline L4_Word_t L4_BootInfo_Entries (const void * ptr)
{
    L4_BootInfo_t * b = (L4_BootInfo_t *) ptr;
    return b->num_entries;
}
# 71 "../../../user/util/kickstart/bootinfo.h" 2


L4_BootRec_t * init_bootinfo (L4_BootInfo_t * bi);

L4_BootRec_t * record_bootinfo_modules (L4_BootInfo_t * bi,
     L4_BootRec_t * rec,
     mbi_t * mbi,
     mbi_module_t orig_mbi_modules[],
     unsigned int decode_count);

L4_BootRec_t * record_bootinfo_mbi (L4_BootInfo_t * bi,
        L4_BootRec_t * rec,
        mbi_t * mbi);

}
# 50 "../../../user/util/kickstart/elf.h" 2
# 75 "../../../user/util/kickstart/elf.h"
class ehdr_t
{
public:
    unsigned char ident[16];
    L4_Word16_t type;
    L4_Word16_t machine;
    L4_Word32_t version;
    L4_Word64_t entry;
    L4_Word64_t phoff;
    L4_Word64_t shoff;
    L4_Word32_t flags;
    L4_Word16_t ehsize;
    L4_Word16_t phentsize;
    L4_Word16_t phnum;
    L4_Word16_t shentsize;
    L4_Word16_t shnum;
    L4_Word16_t shstrndx;

    bool is_32bit (void) { return ident[4] == 1; }
    bool is_64bit (void) { return ident[4] == 2; }
};






class phdr_t
{
public:
    L4_Word32_t type;

    L4_Word32_t flags;

    L4_Word64_t offset;
    L4_Word64_t vaddr;
    L4_Word64_t paddr;
    L4_Word64_t fsize;
    L4_Word64_t msize;



    L4_Word64_t align;
};

enum phdr_type_e
{
    PT_LOAD = 1
};

enum phdr_flags_e
{
    PF_X = 1,
    PF_W = 2,
    PF_R = 4
};






class shdr_t
{
public:
    L4_Word32_t name;
    L4_Word32_t type;
    L4_Word64_t flags;
    L4_Word64_t addr;
    L4_Word64_t offset;
    L4_Word64_t size;
    L4_Word32_t link;
    L4_Word32_t info;
    L4_Word64_t addralign;
    L4_Word64_t entsize;
};

enum shdr_type_e
{
    SHT_PROGBITS = 1,
    SHT_NOBITS = 8
};

enum shdr_flags_e
{
    SHF_WRITE = 1,
    SHF_ALLOC = 2,
    SHF_EXECINSTR = 4
};
# 181 "../../../user/util/kickstart/elf.h"
typedef bool (* L4_MemCheck_Func_t) (L4_Word_t start, L4_Word_t end);

bool elf_load (L4_Word_t file_start,
        L4_Word_t file_end,
        L4_Word_t *memory_start,
        L4_Word_t *memory_end,
        L4_Word_t *entry,
        L4_Word_t *type,
        L4_MemCheck_Func_t check);

bool elf_find_sections (L4_Word_t addr,
   BI32::L4_Boot_SimpleExec_t * exec);

bool elf_find_sections (L4_Word_t addr,
   BI64::L4_Boot_SimpleExec_t * exec);
# 37 "../../../user/util/kickstart/elf.cc" 2
# 1 "../../../user/util/kickstart/lib.h" 1
# 37 "../../../user/util/kickstart/lib.h"
template<typename T> inline const T& min(const T& a, const T& b)
{
    if (b < a)
        return b;
    return a;
}

template<typename T> inline const T& max(const T& a, const T& b)
{
    if (a < b)
        return b;
    return a;
}






extern "C" unsigned strlen( const char *src ) __attribute__((weak));
extern "C" void strcpy( char *dst, const char *src ) __attribute__((weak));
extern "C" int strcmp( const char *s1, const char *s2 ) __attribute__((weak));
extern "C" int strncmp( const char *s1, const char *s2, unsigned int n ) __attribute__((weak));
extern "C" char *strstr(const char *s, const char *find) __attribute__((weak));
extern "C" unsigned long strtoul(const char *cp, char **endp, int base) __attribute__((weak));
extern "C" char *strchr(const char *p, int ch) __attribute__((weak));
extern "C" void memcopy(L4_Word_t dst, L4_Word_t src, L4_Word_t len) __attribute__((weak));
extern "C" void memset(L4_Word_t dst, L4_Word8_t val, L4_Word_t len) __attribute__((weak));

extern inline void memcopy(void *dst, void *src, L4_Word_t len)
{
    memcopy( L4_Word_t(dst), L4_Word_t(src), len );
}

extern inline bool is_intersection(
 L4_Word_t start1, L4_Word_t end1,
 L4_Word_t start2, L4_Word_t end2
 )
{
    return ((start1 >= start2) && (start1 <= end2))
 || ((end1 >= start2) && (end1 <= end2))
 || ((start1 <= start2) && (end1 >= end2));
}
# 38 "../../../user/util/kickstart/elf.cc" 2







bool elf_load32 (L4_Word_t file_start,
   L4_Word_t file_end,
   L4_Word_t *memory_start,
   L4_Word_t *memory_end,
   L4_Word_t *entry,
   L4_MemCheck_Func_t check);

bool elf_find_sections32 (L4_Word_t addr,
     BI32::L4_Boot_SimpleExec_t * exec);
# 62 "../../../user/util/kickstart/elf.cc"
bool elf_find_sections64 (L4_Word_t addr,
     BI32::L4_Boot_SimpleExec_t * exec);
# 73 "../../../user/util/kickstart/elf.cc"
bool elf_load64 (L4_Word_t file_start,
   L4_Word_t file_end,
   L4_Word_t *memory_start,
   L4_Word_t *memory_end,
   L4_Word_t *entry,
   L4_MemCheck_Func_t check)
{

    ehdr_t* eh = (ehdr_t*) file_start;

    printf("  (%p-%p)",
           (void *) file_start,
           (void *) file_end);


    if (eh->type != 2)
    {

        printf("  No executable\n");
        return false;
    }


    if (eh->phoff == 0)
    {

        printf("  Wrong PHDR table offset\n");
        return false;
    }

    printf("   => %p\n", (void *)(L4_Word_t)eh->entry);
    *entry = eh->entry;


    L4_Word_t max_addr = 0U;
    L4_Word_t min_addr = ~0U;


    for (L4_Word_t i = 0; i < eh->phnum; i++)
    {

        phdr_t* ph = (phdr_t*)(L4_Word_t)
     (file_start + eh->phoff + eh->phentsize * i);

        if (ph->msize < ph->fsize)
            ph->msize = ph->fsize;


        if (ph->type == PT_LOAD)
        {
            L4_Word_t src_start = file_start + ph->offset;
            L4_Word_t src_end = src_start + ph->msize;
            L4_Word_t dst_start = ph->paddr;
            L4_Word_t dst_end = dst_start + ph->msize;

            printf("  (%p-%p) -> %p-%p\n",
                   (void *) src_start,
                   (void *) src_end,
                   (void *) dst_start,
                   (void *) dst_end);

            if (check && !check(dst_start, dst_end))
                return false;

            memcopy(dst_start, src_start, ph->fsize);

            memset(dst_start + ph->fsize, 0, ph->msize - ph->fsize);

            min_addr = min(min_addr, dst_start);
            max_addr = max(max_addr, dst_end);
        }
    }


    *memory_start = min_addr;
    *memory_end = max_addr;


    return true;
}


bool elf_find_sections64 (L4_Word_t addr,
        BI32::L4_Boot_SimpleExec_t * exec)
{

    ehdr_t * eh = (ehdr_t *) addr;

    if (eh->type != 2)

 return false;

    if (eh->phoff == 0)

        return false;


    memset ((L4_Word_t) exec, 0, sizeof (*exec));
    exec->type = 0x0002;
    exec->version = 1;
    exec->initial_ip = eh->entry;
    exec->offset_next = sizeof (*exec);
    exec->flags = eh->ident[4];

    if (eh->phoff != 0 && eh->shoff == 0)
    {





 for (L4_Word_t i = 0; i < eh->phnum; i++)
 {
     phdr_t * ph = (phdr_t *) (L4_Word_t) (addr + eh->phoff + eh->phentsize * i);


     if ((ph->flags & PF_W) == 0)
     {
  exec->text_pstart = ph->paddr;
  exec->text_vstart = ph->paddr;
  exec->text_size = ph->fsize;
     }
     else
     {
  exec->data_pstart = ph->paddr;
  exec->data_vstart = ph->paddr;
  exec->data_size = ph->fsize;
     }

     if (ph->msize > ph->fsize)
     {

  exec->bss_pstart = ph->paddr + ph->fsize;
  exec->bss_vstart = ph->vaddr + ph->fsize;
  exec->bss_size = ph->msize - ph->fsize;
     }
 }

 return true;
    }







    L4_Word_t tlow = ~0UL, thigh = 0;
    L4_Word_t dlow = ~0UL, dhigh = 0;
    L4_Word_t blow = ~0UL, bhigh = 0;
    for (L4_Word_t i = 0; i < eh->shnum; i++)
    {
 shdr_t * sh = (shdr_t *) (L4_Word_t)
     (addr + eh->shoff + eh->shentsize * i);

 if (sh->type == SHT_PROGBITS)
 {

     if ((sh->flags & SHF_ALLOC) &&
  ((sh->flags & SHF_EXECINSTR) || (~sh->flags & SHF_WRITE)))
     {
  if (sh->addr < tlow)
      tlow = sh->addr;
  if (sh->addr + sh->size > thigh)
      thigh = sh->addr + sh->size;
     }

     else if ((sh->flags & SHF_ALLOC) &&
       (sh->flags & SHF_WRITE))
     {
  if (sh->addr < dlow)
      dlow = sh->addr;
  if (sh->addr + sh->size > dhigh)
      dhigh = sh->addr + sh->size;
     }
 }
 else if (sh->type == SHT_NOBITS)
 {

     if (sh->addr < blow)
  blow = sh->addr;
     if (sh->addr + sh->size > bhigh)
  bhigh = sh->addr + sh->size;
 }
    }
# 267 "../../../user/util/kickstart/elf.cc"
    for (L4_Word_t i = 0; i < eh->phnum; i++)
    {
 phdr_t * ph = (phdr_t *) (L4_Word_t)
     (addr + eh->phoff + eh->phentsize * i);

 if ((tlow >= ph->vaddr && tlow < (ph->vaddr + ph->msize)))
 {
     exec->text_pstart = (ph->paddr + tlow - ph->vaddr);
     exec->text_vstart = tlow;
     exec->text_size = thigh - tlow;
 }
 if ((dlow >= ph->vaddr && dlow < (ph->vaddr + ph->msize)))
 {
     exec->data_pstart = (ph->paddr + dlow - ph->vaddr);
     exec->data_vstart = dlow;
     exec->data_size = dhigh - dlow;
 }
 if ((blow >= ph->vaddr && blow < (ph->vaddr + ph->msize)))
 {
     exec->bss_pstart = (ph->paddr + blow - ph->vaddr);
     exec->bss_vstart = blow;
     exec->bss_size = bhigh - blow;
 }
    }

    return true;
}
