module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Using the Karnaugh map to translate into the minimal SOP form:
    assign out = (~a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) | (~a & b & ~c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & ~d) | (a & ~b & c & ~d);

endmodule
