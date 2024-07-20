module top_module (
    input a,
    input b,
    input c,
    input d,
    output out
);
    
    assign out = (~c & ~d) 
               | (~c & ~b & a) 
               | (~b & ~a & d) 
               | (~c & a & b) 
               | (b & c & d)
               | (c & ~a & d)
               | (~a & c & d);

endmodule
