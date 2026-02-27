#include "replay-context.h"
#include "replay-shared.h"

#include "../../include/slang-record-api.h"

#include "../core/slang-blob.h"

using namespace SlangRecord;

static inline RecordFlag toFlag(uint32_t f)
{
    return static_cast<RecordFlag>(f & 0x7);
}

// ============================================================================
// State queries
// ============================================================================

SLANG_API bool slangRecord_isActive()
{
    return ReplayContext::get().isActive();
}

SLANG_API bool slangRecord_isRecording()
{
    return ReplayContext::get().isRecording();
}

// ============================================================================
// Locking
// ============================================================================

SLANG_API void* slangRecord_acquireLock()
{
    auto& ctx = ReplayContext::get();
    if (!ctx.isActive())
        return nullptr;
    auto* guard = new std::unique_lock<std::recursive_mutex>(ctx.lock());
    return static_cast<void*>(guard);
}

SLANG_API void slangRecord_releaseLock(void* lockHandle)
{
    if (!lockHandle)
        return;
    delete static_cast<std::unique_lock<std::recursive_mutex>*>(lockHandle);
}

// ============================================================================
// Call recording
// ============================================================================

SLANG_API void slangRecord_beginCall(const char* signature, ISlangUnknown* thisObj)
{
    ReplayContext::get().beginCallWithSignature(signature, thisObj);
}

SLANG_API void slangRecord_beginStaticCall(const char* signature)
{
    auto& ctx = ReplayContext::get();
    if (!ctx.isActive())
        return;
    ctx.beginStaticCallWithSignature(signature);
}

// ============================================================================
// Primitive value recording
// ============================================================================

SLANG_API void slangRecord_recordBool(uint32_t flags, bool value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordInt32(uint32_t flags, int32_t value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordUInt32(uint32_t flags, uint32_t value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordInt64(uint32_t flags, int64_t value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordUInt64(uint32_t flags, uint64_t value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordFloat(uint32_t flags, float value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordDouble(uint32_t flags, double value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

SLANG_API void slangRecord_recordString(uint32_t flags, const char* value)
{
    ReplayContext::get().record(toFlag(flags), value);
}

// ============================================================================
// POD struct recording
// ============================================================================

SLANG_API void slangRecord_recordPOD(uint32_t flags, const void* data, uint32_t size)
{
    ReplayContext::get().recordPOD(toFlag(flags), data, size);
}

// ============================================================================
// Blob recording
// ============================================================================

SLANG_API void slangRecord_recordBlob(uint32_t flags, const void* data, size_t size)
{
    auto& ctx = ReplayContext::get();
    if (!ctx.isActive())
        return;
    auto f = toFlag(flags);
    if (!data || size == 0)
    {
        ISlangBlob* nullBlob = nullptr;
        ctx.recordBlobByHash(f, nullBlob);
        return;
    }
    Slang::ComPtr<ISlangBlob> blob = Slang::RawBlob::create(data, size);
    ISlangBlob* blobPtr = blob.get();
    ctx.recordBlobByHash(f, blobPtr);
}

// ============================================================================
// COM object handle recording
// ============================================================================

SLANG_API void slangRecord_recordHandle(uint32_t flags, ISlangUnknown* obj)
{
    auto& ctx = ReplayContext::get();
    if (!ctx.isActive())
        return;
    uint64_t h = obj ? ctx.getProxyHandle(obj) : kNullHandle;
    ctx.recordHandle(toFlag(flags), h);
}

// ============================================================================
// Proxy management
// ============================================================================

SLANG_API uint64_t slangRecord_registerProxy(
    ISlangUnknown* proxy,
    ISlangUnknown* implementation)
{
    return ReplayContext::get().registerProxy(proxy, implementation);
}

SLANG_API void slangRecord_unregisterProxy(ISlangUnknown* proxyIdentity)
{
    ReplayContext::get().unregisterProxy(proxyIdentity);
}

SLANG_API uint64_t slangRecord_getProxyHandle(ISlangUnknown* obj)
{
    if (!obj)
        return kNullHandle;
    return ReplayContext::get().getProxyHandle(obj);
}
