module top_module (
	input clk,
	input in,
	output reg out
);

	// Initialize the output signal to 0
	initial begin
		out = 0;
	end

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		out <= out ^ in; // Toggle output on clock edge based on XOR with input
	end

endmodule
