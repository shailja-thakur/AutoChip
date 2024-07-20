module top_module(
    input a,
    input b,
    output out
);
    // internal wire to hold the OR gate output
    wire or_out;

    // OR gate
    assign or_out = a | b;

    // Inverter
    assign out = ~or_out;

endmodule
