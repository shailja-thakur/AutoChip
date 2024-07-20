module top_module(
    input a,
    input b,
    output out
);
    // OR gate
    wire or_out;
    assign or_out = a | b;

    // Inverter
    wire invert_out;
    assign invert_out = ~or_out;

    // Output
    assign out = invert_out;
endmodule
