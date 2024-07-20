module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~a & ~b & ~c) | (~a & ~b & ~d) | (~a & c & d) | 
                 (a & c & ~d) | (b & ~c & ~d) | (~c & ~d & a) | 
                 (c & d & a & ~(~a & c & ~d)) | 
                 (~a & b & c & d);
    
endmodule
