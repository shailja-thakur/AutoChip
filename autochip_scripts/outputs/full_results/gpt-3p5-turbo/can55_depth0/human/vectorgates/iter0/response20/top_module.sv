module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    // Circuit to compute the bitwise-OR of the two vectors
    assign out_or_bitwise = a | b;
    
    // Circuit to compute the logical-OR of the two vectors
    assign out_or_logical = |{a, b};
    
    // Circuit to compute the inverse (NOT) of both vectors
    assign out_not = {~b, ~a};
    
endmodule
