module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = ((!a && !b && c) || (a && !b && d) || (a && b && c) || (!a && b && !d)) ? 1 : 0;

endmodule
