module top_module (
    input in1,
    input in2,
    input in3,
    output wire out
);

    // Two-input XNOR gate
    wire xnor_output;
    assign xnor_output = ~(in1 ^ in2);

    // Two-input XOR gate
    assign out = xnor_output ^ in3;

endmodule
