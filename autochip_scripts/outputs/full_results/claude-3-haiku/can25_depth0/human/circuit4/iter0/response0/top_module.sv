module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

assign q = (b & ~c) | (a & c) | (~a & b & d) | (~a & ~b & c & d);

endmodule
