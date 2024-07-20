module top_module (
    input x3,
    input x2,
    input x1,
    output f
);

wire a1, a2, a3, a4;

assign a1 = ~x3 & x2 & ~x1;
assign a2 = ~x3 & x2 & x1;
assign a3 = x3 & ~x2 & x1;
assign a4 = x3 & x2 & x1;

assign f = a1 | a2 | a3 | a4;

endmodule
