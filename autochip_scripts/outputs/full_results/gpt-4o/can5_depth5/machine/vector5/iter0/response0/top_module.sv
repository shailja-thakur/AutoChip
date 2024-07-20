module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    wire [24:0] vec1, vec2;

    // First vector: ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
    assign vec1 = ~({ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} });

    // Second vector: {5{a,b,c,d,e}}
    assign vec2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Output: bitwise XOR of vec1 and vec2
    assign out = vec1 ^ vec2;

endmodule
