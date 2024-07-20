module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

// Perform the XOR operation on in1 and in2
logic temp1;
assign temp1 = in1 ^ in2;

// Perform the NOT operation on temp1
logic temp2;
assign temp2 = ~temp1;

// Perform the XOR operation on temp2 and in3
assign out = temp2 ^ in3;

endmodule
