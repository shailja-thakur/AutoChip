module top_module (
	input clk,
	input in,
	output logic out
);
	
	logic prev_out = 0; // Previous value of out
	
	always_ff @(posedge clk) begin
		out <= in ^ prev_out; // Toggle out
		prev_out <= out; // Update prev_out
	end
endmodule
