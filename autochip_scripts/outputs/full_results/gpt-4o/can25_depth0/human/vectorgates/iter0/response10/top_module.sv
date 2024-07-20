module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    assign out_or_bitwise = a | b; // Bitwise OR of a and b
    assign out_or_logical = |(a | b); // Logical OR of a and b
    assign out_not = {~b, ~a}; // NOT b in bits [5:3] and NOT a in bits [2:0]
endmodule
