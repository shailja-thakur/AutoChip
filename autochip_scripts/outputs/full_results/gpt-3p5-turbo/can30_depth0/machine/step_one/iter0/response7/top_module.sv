module top_module(
	output reg one);

	always @(posedge reset)
		one <= 1'b1;

endmodule
