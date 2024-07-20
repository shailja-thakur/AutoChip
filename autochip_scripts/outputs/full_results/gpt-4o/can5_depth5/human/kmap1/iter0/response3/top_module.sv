module top_module(
    input a,
    input b,
    input c,
    output out
);
    
    // From the Karnaugh map, the simplified Boolean expression is:
    // out = b + c

    assign out = b | c;

endmodule
