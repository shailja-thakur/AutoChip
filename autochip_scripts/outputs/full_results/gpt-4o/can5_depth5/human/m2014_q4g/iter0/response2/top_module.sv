module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Internal wire to connect the output of the XNOR gate to the input of the XOR gate
    wire xnor_out;
    
    // XNOR gate
    assign xnor_out = ~(in1 ^ in2);
    
    // XOR gate
    assign out = xnor_out ^ in3;

endmodule
