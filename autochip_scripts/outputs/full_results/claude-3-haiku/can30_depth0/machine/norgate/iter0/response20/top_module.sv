module top_module(
    input a,
    input b,
    output out
);

    wire nor_out;

    // Implement the logic using a NOR gate
    nor(nor_out, a, b);

    // Invert the output of the NOR gate
    assign out = ~nor_out;

endmodule
