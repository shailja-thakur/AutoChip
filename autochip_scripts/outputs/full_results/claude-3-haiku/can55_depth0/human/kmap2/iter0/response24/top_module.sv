module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

assign out = (a & b) | (~a & b & ~c) | (a & ~b & c) | (a & b & ~d);

endmodule
