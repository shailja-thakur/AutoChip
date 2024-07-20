module top_module (
    input in1,
    input in2,
    output logic out
);

// The input in2 has a bubble, which means it is an active-low input
// Therefore, we need to negate the input in2 before passing it to the AND gate
logic not_in2;

// Negate in2 using the NOT operator
assign not_in2 = ~in2;

// Connect the inputs to the AND gate and assign the output to 'out'
assign out = in1 & not_in2;

endmodule
