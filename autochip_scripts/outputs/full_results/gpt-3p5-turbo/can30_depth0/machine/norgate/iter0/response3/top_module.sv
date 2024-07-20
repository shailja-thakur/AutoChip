module top_module(
	input a, 
	input b,
	output out
);
    // OR gate
    wire or_result;
    assign or_result = a | b;

    // Inverter
    wire inverter_result;
    assign inverter_result = ~or_result;

    // Output
    assign out = inverter_result;
endmodule
