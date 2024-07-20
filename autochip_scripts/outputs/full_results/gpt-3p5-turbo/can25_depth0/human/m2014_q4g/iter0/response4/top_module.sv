module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Define wires
    wire xnor_out;
    
    // Instantiate XNOR gate
    assign xnor_out = (in1 ^ in2) ? 1'b0 : 1'b1;
    
    // Instantiate XOR gate
    assign out = (xnor_out ^ in3) ? 1'b1 : 1'b0;

endmodule
