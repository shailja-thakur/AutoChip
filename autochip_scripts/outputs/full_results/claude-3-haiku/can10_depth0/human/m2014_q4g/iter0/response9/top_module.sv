module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out;

    // Implement the two-input XNOR
    assign xnor_out = ~(in1 ^ in2);

    // Implement the two-input XOR with the XNOR and in3 as inputs
    assign out = xnor_out ^ in3;

endmodule
