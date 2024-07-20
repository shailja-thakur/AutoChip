module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic temp;
    
    // Two-input XNOR
    assign temp = ~(in1 ^ in2);
    
    // Two-input XOR
    assign out = temp ^ in3;

endmodule
