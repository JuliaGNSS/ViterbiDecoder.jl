module ViterbiDecoder

    using Base.Libc.Libdl
    using viterbi_jll

    export viterbi_decode, convolutional_encode

    function viterbi_decode(constraint, polynomials, bits)
        !all([x == '1' || x == '0' for x in bits]) && throw(ArgumentError("Bits must only contain 1s and 0s"))
        isempty(polynomials) && throw(ArgumentError("polynomials must not be empty"))
        !all(0 .< polynomials .< 1 << constraint) && throw(ArgumentError("All polynomials must be between 1 and 1 << constraint - 1 ($(1 << constraint - 1))"))
        decoded_bits = Vector{UInt8}(undef, ceil(Int, length(bits) / length(polynomials)) + 1)
        ccall(("decode", libviterbi), Cvoid, (Int32, Ptr{Int32}, Cstring, Ptr{UInt8}), constraint, Int32.(polynomials), bits, decoded_bits)
        decoded_bits[end] = 0
        return GC.@preserve decoded_bits unsafe_string(pointer(decoded_bits))
    end

    function convolutional_encode(constraint, polynomials, bits)
        !all([x == '1' || x == '0' for x in bits]) && throw(ArgumentError("Bits must only contain 1s and 0s"))
        isempty(polynomials) && throw(ArgumentError("polynomials must not be empty"))
        !all(0 .< polynomials .< 1 << constraint) && throw(ArgumentError("All polynomials must be between 1 and 1 << constraint - 1 ($(1 << constraint - 1))"))
        encoded_bits = Vector{UInt8}(undef, length(bits) * length(polynomials) + 2 * (constraint - 1) + 1)
        ccall(("encode", libviterbi), Cvoid, (Int32, Ptr{Int32}, Cstring, Ptr{UInt8}), constraint, Int32.(polynomials), bits, encoded_bits)
        encoded_bits[end] = 0
        return GC.@preserve encoded_bits unsafe_string(pointer(encoded_bits))
    end

end
