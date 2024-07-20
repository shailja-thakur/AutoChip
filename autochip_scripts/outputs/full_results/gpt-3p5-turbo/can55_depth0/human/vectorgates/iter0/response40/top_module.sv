module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    wire [2:0] a_not, b_not;
  
    // bitwise OR output
    assign out_or_bitwise = a | b;
  
    // logical OR output
    assign out_or_logical = |out_or_bitwise;
  
    // inverse of a and b
    assign a_not = ~a;
    assign b_not = ~b;
  
    // assign inverse of b to upper half of out_not and inverse of a to lower half
    assign out_not = {b_not, a_not};

endmodule
