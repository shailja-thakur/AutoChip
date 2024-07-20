module top_module(
    input x,
    input y,
    output z);

    // Verilog code for the logic gate
    assign z = ~(x ^ y);

endmodule
