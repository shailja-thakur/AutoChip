module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    // Boolean function from the Karnaugh map
    assign out = (~c & ~d) | (~b & ~c & d) | (a & ~b & c) | (a & b & ~c) | (~a & b & d);

endmodule
