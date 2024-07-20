module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out;

    // Instantiate the XNOR gate
    assign xnor_out = ~(in1 ^ in2);

    // Instantiate the XOR gate
    assign out = xnor_out ^ in3;

endmodule
