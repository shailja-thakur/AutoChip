module top_module (
	input wire clk,
	input wire in,
	output reg out
);

	// Initial state of the output signal
	initial begin
		out = 0;
	end

	// Always block to handle the clock edge and output toggling
	always @(posedge clk) begin
		out <= out ^ in;
	end

endmodule
