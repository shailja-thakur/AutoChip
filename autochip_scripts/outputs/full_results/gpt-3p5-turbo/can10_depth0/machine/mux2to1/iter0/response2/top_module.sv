module top_module (
	input a,
	input b,
	input sel,
	output out
);
	//Declare wire to hold output value
	wire out;

	//Multiplexer circuit
	assign out = (sel == 1'b1) ? b : a;
endmodule
