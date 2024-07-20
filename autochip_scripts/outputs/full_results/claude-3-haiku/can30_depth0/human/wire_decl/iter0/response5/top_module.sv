module top_module (
    input a,
    input b,
    input c,
    input d,
    output out,
    output out_n
);

wire and_out_1;
wire and_out_2;

assign and_out_1 = a & b;
assign and_out_2 = c & d;

assign out = and_out_1 | and_out_2;
assign out_n = ~out;

endmodule
