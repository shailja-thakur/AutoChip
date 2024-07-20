module top_module (
    input a,
    input b,
    input sel,
    output out
);

    // Implement the multiplexer functionality
    assign out = sel ? b : a;

endmodule
