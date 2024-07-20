module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

// Implement a 2-input XNOR gate
logic xnor_out;
assign xnor_out = ~(in1 ^ in2);

// Implement a 2-input XOR gate with one input from the XNOR gate and the other from in3
assign out = xnor_out ^ in3;

endmodule
