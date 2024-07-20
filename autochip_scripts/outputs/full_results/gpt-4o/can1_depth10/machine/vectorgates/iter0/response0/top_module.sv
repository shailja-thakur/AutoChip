module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

assign out_or_bitwise = a | b;
assign out_or_logical = |a || |b; // Logical OR between the reduction OR of 'a' and 'b'
assign out_not = {~b, ~a}; // Concatenate the bitwise NOT of 'b' and 'a' in reverse order

endmodule
