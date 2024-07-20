module top_module(
    input a,
    input b,
    output out
);

    // Logic circuit
    assign out = ~(a ^ b);

endmodule
