module top_module(
    input a,
    input b,
    output out
);

// Logic circuit implementation
assign out = ~(a ^ b);

endmodule
