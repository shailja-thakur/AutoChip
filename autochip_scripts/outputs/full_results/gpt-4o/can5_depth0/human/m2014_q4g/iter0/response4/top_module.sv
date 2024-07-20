module top_module (
    input in1,
    input in2,
    input in3,
    output out
);
    wire xnor_out;

    assign xnor_out = ~(in1 ^ in2); // XNOR output
    assign out = xnor_out ^ in3;    // XOR with in3

endmodule
