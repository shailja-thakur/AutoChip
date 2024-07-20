module top_module(
    input a,
    input b,
    output out
);
    // Implement NOR gate
    assign out = ~(a | b);
endmodule
