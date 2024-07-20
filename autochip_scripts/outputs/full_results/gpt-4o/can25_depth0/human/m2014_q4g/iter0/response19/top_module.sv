module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out; // Intermediate signal to hold XNOR output

    // Instantiate the XNOR gate
    assign xnor_out = ~(in1 ^ in2);

    // Instantiate the XOR gate with the XNOR output and in3 as inputs
    assign out = xnor_out ^ in3;

endmodule
