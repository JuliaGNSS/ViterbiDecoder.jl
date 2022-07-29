[![](https://img.shields.io/badge/docs-stable-blue.svg)](https://JuliaGNSS.github.io/ViterbiDecoder.jl/stable)
[![](https://img.shields.io/badge/docs-dev-blue.svg)](https://JuliaGNSS.github.io/ViterbiDecoder.jl/dev)

# ViterbiDecoder

This package provides a Viterbi decoder as well as a convolutional encoder.

The first argument is the constraint, the second argument are the polynomials and the third
argument are the bits provided as a String.

# Examples

```julia
    viterbi_decode(3, [7, 5], "0011100001100111111000101100111011") == "010111001010001"
    # With one error bit
    viterbi_decode(3, [7, 5], "0011100001100111110000101100111011") == "010111001010001"

    viterbi_decode(3, [6, 5], "011011011101101011") == "1001101"
    # With two error bits
    viterbi_decode(3, [6, 5], "111011011100101011") == "1001101"

    viterbi_decode(7, [91, 117, 121], "1110101100011110111100011011") == "10110111"

    convolutional_encode(3, [7, 5], "010111001010001") == "0011100001100111111000101100111011"
```