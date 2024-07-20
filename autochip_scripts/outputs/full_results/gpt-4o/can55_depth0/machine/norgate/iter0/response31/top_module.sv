module top_module(
    input a, 
    input b,
    output out
);
	// OR gate
    wire or_out;
    assign or_out = a | b;

	// Inverter
    assign out = ~or_out;
endmodule
