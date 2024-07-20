module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    wire [24:0] vec1;
    wire [24:0] vec2;

    // Generate vec1
    assign vec1 = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};

    // Generate vec2
    assign vec2 = {5{a, b, c, d, e}};

    // Perform bitwise xor
    assign out = vec1 ^ vec2;
endmodule
