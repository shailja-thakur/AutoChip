module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);

    // Create repeating vectors for each signal
    wire [24:0] vec1;
    wire [24:0] vec2;
    
    assign vec1 = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };
    assign vec2 = { {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} };

    // Compute bitwise XOR of the two vectors
    assign out = vec1 ^ vec2;

endmodule
