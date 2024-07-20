module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) 
               | (~c & ~b & a) 
               | (~c & b & ~a) 
               | (~b & c & a) 
               | (~d & c & a) 
               | (b & ~d & c) 
               | (b & d & ~c & a) 
               | (b & ~a & ~d & ~c);

endmodule
