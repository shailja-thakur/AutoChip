module top_module(
    input a, 
    input b,
    input c,
    output out
);

    // Simplified Boolean expression from Karnaugh map: out = a | b

    assign out = a | b;

endmodule
