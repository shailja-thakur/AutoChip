module top_module(
    input a,
    input b,
    output out
);

    // OR gate
    wire or_output;
    assign or_output = a | b;

    // Inverter
    wire inv_output;
    assign inv_output = ~or_output;

    // Output
    assign out = inv_output;

endmodule
