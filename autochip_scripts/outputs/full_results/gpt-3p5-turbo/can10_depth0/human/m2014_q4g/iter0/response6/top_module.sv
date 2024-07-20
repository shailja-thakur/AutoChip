module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    // Declare the intermediate signals
    logic xnor_output;
    
    // Implement the XNOR gate
    assign xnor_output = ~(in1 ^ in2);
    
    // Implement the XOR gate
    assign out = xnor_output ^ in3;

endmodule
