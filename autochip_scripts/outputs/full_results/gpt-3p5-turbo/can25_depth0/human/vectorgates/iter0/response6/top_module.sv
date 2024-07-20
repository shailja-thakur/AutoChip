module top_module(
    input [2:0] a, 
    input [2:0] b, 
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);

    wire [2:0] inverse_a;
    wire [2:0] inverse_b;

    assign inverse_a = ~a;
    assign inverse_b = ~b;

    assign out_or_bitwise = a | b;
    assign out_or_logical = |out_or_bitwise;
    assign out_not = {inverse_a, inverse_b};
     
endmodule
