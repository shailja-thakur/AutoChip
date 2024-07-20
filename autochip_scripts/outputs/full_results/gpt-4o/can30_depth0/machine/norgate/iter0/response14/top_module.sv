module top_module(
    input a, 
    input b,
    output out
);
    // Internal wire for OR gate output
    wire or_output;

    // OR gate
    assign or_output = a | b;

    // Inverter
    assign out = ~or_output;

endmodule
