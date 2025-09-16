//TEST:SIMPLE(filecheck=METAL): -target metal -stage compute -entry computeMain
//TEST:SIMPLE(filecheck=METAL_FLOAT): -target metal -stage compute -entry computeMain -DFLOAT
//TEST:SIMPLE(filecheck=METALLIB): -target metallib -stage compute -entry computeMain
// NOTE: metal RWBuffer not currently handled by slang-test, cannot substitute with RWStructuredBuffer.
//TEST(compute, metal):COMPARE_COMPUTE_EX(filecheck-buffer=BUF):-metal -compute -shaderobj -output-using-type

// METAL_FLOAT: floating point atomic operation

//METALLIB: @computeMain

//TEST_INPUT: ubuffer(data=[0], stride=4, count=16):out,name outBuffer
RWStructuredBuffer<int> outBuffer;
//TEST_INPUT: ubuffer(format=R_Int32, data=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15], stride=1):name intBuffer
RWBuffer<int> intBuffer;
//TEST_INPUT: ubuffer(format=R_UInt32, data=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15], stride=1):name uintBuffer
RWBuffer<uint> uintBuffer;
//TEST_INPUT: ubuffer(format=R_Float32, data=[0.0 1.0], stride=4):name floatBuffer
RWBuffer<float> floatBuffer;

void test()
{
    int valInt = 1;
    int originalValueInt = 999;
    int compareValueInt = 1;

    uint valUInt = 1;
    uint originalValueUInt = 999;
    int compareValueUInt = 1;

    float valFloat = 1.0f;
    float originalValueFloat = 999.0;

    // buffer
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
    InterlockedAdd(intBuffer[i++], valInt);
    InterlockedAnd(intBuffer[i++], valInt);
    InterlockedMax(intBuffer[i++], valInt);
    InterlockedMin(intBuffer[i++], valInt);
    InterlockedOr(intBuffer[i++], valInt);
    InterlockedXor(intBuffer[i++], valInt);
    InterlockedAdd(intBuffer[i++], valInt, originalValueInt);
    // BUF: 7
    outBuffer[o++] = originalValueInt;
    InterlockedAnd(intBuffer[i++], valInt, originalValueInt);
    // BUF: 8
    outBuffer[o++] = originalValueInt;
    InterlockedMax(intBuffer[i++], valInt, originalValueInt);
    // BUF: 9
    outBuffer[o++] = originalValueInt;
    InterlockedMin(intBuffer[i++], valInt, originalValueInt);
    // BUF: 10
    outBuffer[o++] = originalValueInt;
    InterlockedOr(intBuffer[i++], valInt, originalValueInt);
    // BUF: 11
    outBuffer[o++] = originalValueInt;
    InterlockedXor(intBuffer[i++], valInt, originalValueInt);
    // BUF: 12
    outBuffer[o++] = originalValueInt;
    InterlockedExchange(intBuffer[i++], valInt, originalValueInt);
    // BUF: 13
    outBuffer[o++] = originalValueInt;
    InterlockedCompareExchange(intBuffer[i++], valInt, compareValueInt, originalValueInt);
    // BUF: 14
    outBuffer[o++] = originalValueInt;
    InterlockedCompareStore(intBuffer[i++], valInt, compareValueInt);

    i = 0;
    InterlockedAdd(uintBuffer[i++], valUInt);
    InterlockedAnd(uintBuffer[i++], valUInt);
    InterlockedMax(uintBuffer[i++], valUInt);
    InterlockedMin(uintBuffer[i++], valUInt);
    InterlockedOr(uintBuffer[i++], valUInt);
    InterlockedXor(uintBuffer[i++], valUInt);
    InterlockedAdd(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 7
    outBuffer[o++] = originalValueUInt;
    InterlockedAnd(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 8
    outBuffer[o++] = originalValueUInt;
    InterlockedMax(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 9
    outBuffer[o++] = originalValueUInt;
    InterlockedMin(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 10
    outBuffer[o++] = originalValueUInt;
    InterlockedOr(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 11
    outBuffer[o++] = originalValueUInt;
    InterlockedXor(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 12
    outBuffer[o++] = originalValueUInt;
    InterlockedExchange(uintBuffer[i++], valUInt, originalValueUInt);
    // BUF: 13
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareExchange(uintBuffer[i++], valUInt, compareValueUInt, originalValueUInt);
    // BUF: 14
    outBuffer[o++] = originalValueUInt;
    InterlockedCompareStore(uintBuffer[i++], valUInt, compareValueUInt);

#ifdef FLOAT
    //float
    i = 0;
    InterlockedExchange(floatBuffer[i++], valFloat);
    InterlockedExchange(floatBuffer[i++], valFloat, originalValueFloat);
#endif //FLOAT
}

[numthreads(1, 1, 1)]
[shader("compute")]
void computeMain()
{
    test();
}
