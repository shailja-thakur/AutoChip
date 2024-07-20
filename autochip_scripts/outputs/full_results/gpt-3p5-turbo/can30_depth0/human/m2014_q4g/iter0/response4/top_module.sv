module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // XNOR gate implementation
    assign out_xnor = in1 ^ in2;
    
    // XOR gate implementation
    assign out = out_xnor ^ in3;

endmodule
