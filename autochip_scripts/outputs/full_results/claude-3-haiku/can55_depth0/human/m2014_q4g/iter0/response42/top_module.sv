module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_output;

    // Implement the two-input XNOR
    assign xnor_output = ~(in1 ^ in2);

    // Implement the two-input XOR with the XNOR output and in3
    assign out = xnor_output ^ in3;

endmodule
