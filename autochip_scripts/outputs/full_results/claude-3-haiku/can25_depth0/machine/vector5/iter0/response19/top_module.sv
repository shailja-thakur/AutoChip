module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // First vector: 25 bits with value 1 if the corresponding input signal is 0, and 0 if the corresponding input signal is 1
    wire [24:0] vec1 = {~{5{a}}, ~{5{b}}, ~{5{c}}, ~{5{d}}, ~{5{e}}};

    // Second vector: 25 bits with value 1 if the corresponding input signal is 1, and 0 if the corresponding input signal is 0
    wire [24:0] vec2 = {{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};

    // Compute the bitwise exclusive-or of the two vectors
    assign out = vec1 ^ vec2;

endmodule
