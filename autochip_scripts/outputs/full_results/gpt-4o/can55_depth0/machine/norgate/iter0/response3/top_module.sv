module top_module(
	input a, 
	input b,
	output out
);

    // Internal signal to hold the output of the OR gate
    wire or_output;

    // OR gate
    assign or_output = a | b;

    // Inverter
    assign out = ~or_output;

endmodule
