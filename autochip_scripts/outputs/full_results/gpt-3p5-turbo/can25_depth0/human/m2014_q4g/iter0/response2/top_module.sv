module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // XNOR gate
    assign wire xnor_output = in1 ^ in2;
    
    // XOR gate
    assign out = xnor_output ^ in3;

endmodule
