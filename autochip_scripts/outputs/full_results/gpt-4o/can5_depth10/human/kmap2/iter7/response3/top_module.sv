module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | // Rows 00, 01, 10 (columns 00, 01, 11)
                 (a & ~b & c & d) | // Row 11, columns 01, 11
                 (b & ~c) | // Rows 00, 01, 10 (columns 10, 00, 01)
                 (b & c & d); // Row 10, column 01

endmodule
