module top_module(
    input [2:0] a,
    input [2:0] b,
    output [2:0] out_or_bitwise,
    output out_or_logical,
    output [5:0] out_not
);
    
    wire [2:0] a_not, b_not;

    assign a_not = ~a;
    assign b_not = ~b;
    assign out_or_bitwise = a | b;
    assign out_or_logical = (a != 3'b000) || (b != 3'b000);
    assign out_not = {b_not, a_not};

endmodule
