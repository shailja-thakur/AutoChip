module top_module (
    input a,
    input b,
    output out
);

    // XNOR gate functionality
    assign out = ~(a ^ b);

endmodule
