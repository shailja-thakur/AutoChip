module top_module (
	input clk,
	input in,
	output logic out
);

	// Initial value of the output signal
	initial begin
		out = 0;
	end

	// Always block to handle the posedge of the clock
	always_ff @(posedge clk) begin
		out <= out ^ in;
	end
	
endmodule
