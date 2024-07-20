module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    
    assign out = (~c & ~d) | (~c & a & ~b) | (~b & d) | (a & b & c) | (b & d & ~a);

endmodule
