module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    assign q = (b & ~c & ~d) | (~b & c) | (a & b) | (b & c & d);

endmodule
