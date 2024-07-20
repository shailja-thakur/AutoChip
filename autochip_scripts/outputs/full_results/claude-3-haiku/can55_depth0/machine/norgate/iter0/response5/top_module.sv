module top_module(
    input a,
    input b,
    output out
);

    // Implement the logic gate using Verilog operators
    assign out = ~(a | b);

endmodule
