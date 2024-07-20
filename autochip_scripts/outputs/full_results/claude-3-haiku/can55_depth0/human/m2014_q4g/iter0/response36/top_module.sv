module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_output;

    // Implement two-input XNOR
    assign xnor_output = ~(in1 ^ in2);

    // Implement two-input XOR
    assign out = xnor_output ^ in3;

endmodule
