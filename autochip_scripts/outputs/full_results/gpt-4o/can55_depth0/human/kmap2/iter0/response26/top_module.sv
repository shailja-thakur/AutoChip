module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | (~c & a) | (~c & b & ~a) | (~b & d & ~c) | (b & d & a) | (b & d & c) | (~b & d & c);

endmodule
