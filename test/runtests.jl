using ViterbiDecoder
using Test

@testset "ViterbiDecoder.jl" begin
    @test viterbi_decode(3, [7,5], "0011100001100111111000101100111011") == "010111001010001"
    # With one error bit
    @test viterbi_decode(3, [7,5], "0011100001100111110000101100111011") == "010111001010001"

    @test viterbi_decode(3, [6,5], "011011011101101011") == "1001101"
    # With two error bits
    @test viterbi_decode(3, [6,5], "111011011100101011") == "1001101"

    @test viterbi_decode(7, [91, 117, 121], "1110101100011110111100011011") == "10110111"

    @test convolutional_encode(3, [7, 5], "010111001010001") == "0011100001100111111000101100111011"
end