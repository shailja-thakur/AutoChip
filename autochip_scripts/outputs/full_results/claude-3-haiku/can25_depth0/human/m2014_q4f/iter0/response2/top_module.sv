module top_module (
    input in1,
    input in2,
    output logic out
);

// The 'bubble' on the in2 input of the AND gate indicates that it is active low
// So, we need to invert the in2 input before feeding it to the AND gate
assign out = in1 & ~in2;

endmodule
