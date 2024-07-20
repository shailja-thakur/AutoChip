module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic xnor_out;
    
    // Two-input XNOR
    assign xnor_out = ~(in1 ^ in2);
    
    // Two-input XOR with second input 'in3'
    assign out = xnor_out ^ in3;

endmodule
