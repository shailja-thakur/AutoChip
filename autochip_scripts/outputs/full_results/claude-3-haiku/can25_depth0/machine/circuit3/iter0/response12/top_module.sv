module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire a_or_b, c_or_d;

assign a_or_b = a | b;
assign c_or_d = c | d;
assign q = a_or_b & c_or_d;

endmodule
