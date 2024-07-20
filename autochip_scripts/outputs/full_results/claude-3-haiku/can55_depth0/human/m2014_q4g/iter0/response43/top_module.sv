module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out;

    // Implement a two-input XNOR gate
    assign xnor_out = ~(in1 ^ in2);

    // Implement a two-input XOR gate with the XNOR output and in3
    assign out = xnor_out ^ in3;

endmodule
