module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);
    logic xnor_out;

    assign xnor_out = ~(in1 ^ in2); // XNOR implementation
    assign out = xnor_out ^ in3; // XOR implementation with xnor_out and in3

endmodule
