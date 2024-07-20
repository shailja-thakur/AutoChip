module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    wire or_ab, or_cd;

    // Perform bitwise OR on inputs a and b
    assign or_ab = a | b;
    
    // Perform bitwise OR on inputs c and d
    assign or_cd = c | d;
    
    // Perform bitwise AND on the results of the two OR operations
    assign q = or_ab & or_cd;

endmodule
