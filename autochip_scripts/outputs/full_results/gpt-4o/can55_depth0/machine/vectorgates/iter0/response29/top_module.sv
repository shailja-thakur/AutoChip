module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    assign out_or_bitwise = a | b; // Bitwise OR
    assign out_or_logical = |(a | b); // Logical OR; will be 1 if any bit in (a | b) is 1, otherwise 0
    assign out_not = {~a, ~b}; // Concatenate the bitwise NOT of a and b

endmodule
