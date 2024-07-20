module top_module (
	input clk,
	input a, 
	output reg q
);

	// Define a flip-flop to store the value of q
	always @(posedge clk) begin
		q <= a;
	end

endmodule
