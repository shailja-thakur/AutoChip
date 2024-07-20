module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (c & d) | (~a & ~b & c) | (~a & b) | (a & ~b & ~c) | (a & b & ~c);

endmodule
