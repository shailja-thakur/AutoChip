module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vec1, vec2;

    // Create vec1 with the bitwise NOT of the 5 repeated inputs
    assign vec1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Create vec2 with the 5 repeated inputs
    assign vec2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute the bitwise XOR of vec1 and vec2
    assign out = vec1 ^ vec2;

endmodule
