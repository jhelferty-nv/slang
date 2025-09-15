//TEST:SIMPLE(filecheck=METAL): -target metal -stage compute -entry computeMain
//TEST:SIMPLE(filecheck=METALLIB): -target metallib -stage compute -entry computeMain
// NOTE: metal compute test generates incorrect results
//TEST(compute, metal):COMPARE_COMPUTE_EX(filecheck-buffer=BUF):-metal -compute -output-using-type

//METALLIB: @computeMain

//TEST_INPUT: Texture1D(size=15, content=one):name uintTexture1D
RWTexture1D<uint> uintTexture1D;
//TEST_INPUT: Texture1D(size=15, content=one):name intTexture1D
RWTexture1D<int> intTexture1D;

//TEST_INPUT: Texture1D(size=15, content=one, arrayLength=1):name uintTexture1DArray
RWTexture1DArray<uint> uintTexture1DArray;
//TEST_INPUT: Texture1D(size=15, content=one, arrayLength=1):name intTexture1DArray
RWTexture1DArray<int> intTexture1DArray;

//TEST_INPUT: ubuffer(data=[0], stride=1, count=256):out,name outBuffer
RWStructuredBuffer<int> outBuffer;

void test()
{
    int valInt = 1;
    int originalValueInt = 999;
    int compareValueInt = 1;

    uint valUInt = 1;
    uint originalValueUInt = 999;
    int compareValueUInt = 1;

    // Texture1D
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_exchange
// METAL: .atomic_compare_exchange_weak
// METAL: .atomic_compare_exchange_weak

// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_exchange
// METAL: .atomic_compare_exchange_weak
// METAL: .atomic_compare_exchange_weak
    int o = 0;
    int i = 0;
    InterlockedAdd(uintTexture1D[i++], valUInt);
    InterlockedAnd(uintTexture1D[i++], valUInt);
    InterlockedMax(uintTexture1D[i++], valUInt);
    InterlockedMin(uintTexture1D[i++], valUInt);
    InterlockedOr(uintTexture1D[i++], valUInt);
    InterlockedXor(uintTexture1D[i++], valUInt);
    InterlockedAdd(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedAnd(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedMax(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedMin(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedOr(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedXor(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedExchange(uintTexture1D[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareExchange(uintTexture1D[i++], valUInt, compareValueUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareStore(uintTexture1D[i++], valUInt, compareValueUInt);

    i = 0;
    InterlockedAdd(intTexture1D[i++], valInt);
    InterlockedAnd(intTexture1D[i++], valInt);
    InterlockedMax(intTexture1D[i++], valInt);
    InterlockedMin(intTexture1D[i++], valInt);
    InterlockedOr(intTexture1D[i++], valInt);
    InterlockedXor(intTexture1D[i++], valInt);
    InterlockedAdd(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedAnd(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedMax(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedMin(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedOr(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedXor(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedExchange(intTexture1D[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedCompareExchange(intTexture1D[i++], valInt, compareValueInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedCompareStore(intTexture1D[i++], valInt, compareValueUInt);

    // Texture1DArray
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_exchange
// METAL: .atomic_compare_exchange_weak
// METAL: .atomic_compare_exchange_weak

// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_fetch_add
// METAL: .atomic_fetch_and
// METAL: .atomic_fetch_max
// METAL: .atomic_fetch_min
// METAL: .atomic_fetch_or
// METAL: .atomic_fetch_xor
// METAL: .atomic_exchange
// METAL: .atomic_compare_exchange_weak
// METAL: .atomic_compare_exchange_weak
    i = 0;
    InterlockedAdd(uintTexture1DArray[i++], valUInt);
    InterlockedAnd(uintTexture1DArray[i++], valUInt);
    InterlockedMax(uintTexture1DArray[i++], valUInt);
    InterlockedMin(uintTexture1DArray[i++], valUInt);
    InterlockedOr(uintTexture1DArray[i++], valUInt);
    InterlockedXor(uintTexture1DArray[i++], valUInt);
    InterlockedAdd(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedAnd(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedMax(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedMin(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedOr(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedXor(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedExchange(uintTexture1DArray[i++], valUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareExchange(uintTexture1DArray[i++], valUInt, compareValueUInt, originalValueUInt);
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareStore(uintTexture1DArray[i++], valUInt, compareValueUInt);

    i = 0;
    InterlockedAdd(intTexture1DArray[i++], valInt);
    InterlockedAnd(intTexture1DArray[i++], valInt);
    InterlockedMax(intTexture1DArray[i++], valInt);
    InterlockedMin(intTexture1DArray[i++], valInt);
    InterlockedOr(intTexture1DArray[i++], valInt);
    InterlockedXor(intTexture1DArray[i++], valInt);
    InterlockedAdd(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedAnd(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedMax(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedMin(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedOr(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedXor(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedExchange(intTexture1DArray[i++], valInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedCompareExchange(intTexture1DArray[i++], valInt, compareValueInt, originalValueInt);
    outBuffer[o++] = originalValueInt;
    InterlockedCompareStore(intTexture1DArray[i++], valUInt, compareValueUInt);

    // Copy to output
    int test_count = i+1;
    for (i=0; i<test_count; i++) {
        outBuffer[o + test_count*0 + i*4] = uintTexture1D[i];
        outBuffer[o + test_count*1 + i*4] = intTexture1DArray[i];
        outBuffer[o + test_count*2 + i*4] = uintTexture1D[i];
        outBuffer[o + test_count*3 + i*4] = intTexture1DArray[i];
    }
}

[numthreads(1, 1, 1)]
void computeMain()
{
    test();
}
