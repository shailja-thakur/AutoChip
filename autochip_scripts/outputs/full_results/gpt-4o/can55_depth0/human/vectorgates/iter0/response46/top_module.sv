module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    // Compute the bitwise OR of the vectors
    assign out_or_bitwise = a | b;
    
    // Compute the logical OR of the vectors
    assign out_or_logical = |a | |b;
    
    // Compute the inverse (NOT) of the vectors
    assign out_not = {~b, ~a};
endmodule
