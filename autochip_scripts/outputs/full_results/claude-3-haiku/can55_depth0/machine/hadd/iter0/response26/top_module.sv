module top_module (
    input a,
    input b,
    output sum,
    output cout
);

assign sum = a + b;
assign cout = (a & b);

endmodule
module top_module (
    input a,
    input b,
    output sum,
    output cout
);

wire c;

assign sum = a ^ b ^ c;
assign cout = (a & b) | (a & c) | (b & c);

endmodule
