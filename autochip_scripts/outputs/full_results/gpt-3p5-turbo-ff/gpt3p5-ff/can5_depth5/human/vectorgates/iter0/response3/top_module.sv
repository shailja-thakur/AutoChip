module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    // Bitwise-OR
    assign out_or_bitwise = a | b;
    
    // Logical-OR
    assign out_or_logical = (a != 0) || (b != 0);
    
    // Inverse of b in the upper half of out_not
    assign out_not[5:3] = ~b;
    
    // Inverse of a in the lower half of out_not
    assign out_not[2:0] = ~a;
    
endmodule
