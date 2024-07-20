module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

wire and1, and2, and3, and4;

assign and1 = ~c & ~d;
assign and2 = ~b & c & ~d;
assign and3 = b & ~c & d;
assign and4 = b & c & d;

assign q = and1 | and2 | and3 | and4;

endmodule
