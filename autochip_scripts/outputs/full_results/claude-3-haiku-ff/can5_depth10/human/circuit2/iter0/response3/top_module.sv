module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire and1, and2, or1;

assign and1 = ~a & ~b & ~c & d;
assign and2 = a & b & ~c & ~d;
assign or1 = and1 | and2;

assign q = or1;

endmodule
