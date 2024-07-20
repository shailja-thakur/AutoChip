module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Karnaugh map simplification results in out = b + c
    assign out = b | c;

endmodule
