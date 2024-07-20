module top_module(
    input a, 
    input b,
    input c,
    output out
);
    // Karnaugh map can be simplified to out = a | b | c
    assign out = a | b | c;

endmodule
