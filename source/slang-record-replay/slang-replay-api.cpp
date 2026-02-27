#include "replay-context.h"
#include "../../include/slang-replay-api.h"

using namespace SlangRecord;

// ============================================================================
// External handler registration
// ============================================================================

SLANG_API void slangReplay_setExternalHandler(SlangReplayExternalHandler handler)
{
    ReplayContext::get().setExternalHandler(handler);
}

// ============================================================================
// Current call context
// ============================================================================

SLANG_API uint64_t slangReplay_getCurrentThisHandle()
{
    return ReplayContext::get().getCurrentThisHandle();
}

// ============================================================================
// Stream reading - primitives
// ============================================================================

SLANG_API bool slangReplay_readBool()
{
    bool value = false;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API int32_t slangReplay_readInt32()
{
    int32_t value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API uint32_t slangReplay_readUInt32()
{
    uint32_t value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API int64_t slangReplay_readInt64()
{
    int64_t value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API uint64_t slangReplay_readUInt64()
{
    uint64_t value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API float slangReplay_readFloat()
{
    float value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API double slangReplay_readDouble()
{
    double value = 0;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

SLANG_API const char* slangReplay_readString()
{
    const char* value = nullptr;
    ReplayContext::get().record(RecordFlag::Input, value);
    return value;
}

// ============================================================================
// Stream reading - POD structs
// ============================================================================

SLANG_API void slangReplay_readPOD(void* outData, uint32_t expectedSize)
{
    auto& ctx = ReplayContext::get();
    uint32_t recordedSize = 0;
    ctx.record(RecordFlag::Input, recordedSize);
    if (recordedSize != expectedSize)
    {
        throw Slang::Exception(
            Slang::String("POD size mismatch: expected ") + Slang::String(expectedSize) +
            " but stream has " + Slang::String(recordedSize));
    }
    ctx.readRawBytes(outData, recordedSize);
}

// ============================================================================
// Stream reading - blobs
// ============================================================================

SLANG_API ISlangBlob* slangReplay_readBlob()
{
    ISlangBlob* blob = nullptr;
    ReplayContext::get().recordBlobByHash(RecordFlag::Input, blob);
    return blob;
}

// ============================================================================
// Stream reading - handles
// ============================================================================

SLANG_API uint64_t slangReplay_readHandle()
{
    uint64_t handle = 0;
    ReplayContext::get().recordHandle(RecordFlag::Input, handle);
    return handle;
}

// ============================================================================
// Handle table management
// ============================================================================

SLANG_API void slangReplay_mapHandleToObject(uint64_t handle, ISlangUnknown* obj)
{
    ReplayContext::get().mapHandleToObject(handle, obj);
}

SLANG_API ISlangUnknown* slangReplay_getObjectFromHandle(uint64_t handle)
{
    return ReplayContext::get().getProxy(handle);
}
