module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and1, and2, or1;

assign and1 = a & b;
assign and2 = c & d;
assign or1 = and1 | and2;

assign out = or1;
assign out_n = ~out;

endmodule
