module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    wire xnor_out;

    assign xnor_out = ~(in1 ^ in2); // Implementing XNOR
    assign out = xnor_out ^ in3;    // Input to XOR and output

endmodule
