module top_module (
    input a,
    input b,
    input c,
    input d,
    input e,
    output [24:0] out
);
    
    // The first vector
    wire [24:0] vector1;
    
    // The second vector
    wire [24:0] vector2;
    
    // Compute the first vector
    assign vector1 = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}};
    
    // Compute the second vector
    assign vector2 = {5{a, b, c, d, e}};
    
    // Compute the bitwise exclusive-or of the two vectors
    assign out = vector1 ^ vector2;
    
endmodule
