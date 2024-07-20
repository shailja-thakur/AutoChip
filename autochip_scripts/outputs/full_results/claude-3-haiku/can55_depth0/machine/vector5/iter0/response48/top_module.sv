module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Create the two 25-bit vectors
    wire [24:0] vec1, vec2;

    // Vector 1: {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}
    assign vec1 = {5'b11111 ^ {5{a}}, 5'b11111 ^ {5{b}}, 5'b11111 ^ {5{c}}, 5'b11111 ^ {5{d}}, 5'b11111 ^ {5{e}}};

    // Vector 2: {5{a,b,c,d,e}}
    assign vec2 = {5{a,b,c,d,e}};

    // Compute the bitwise exclusive-or
    assign out = vec1 ^ vec2;

endmodule
