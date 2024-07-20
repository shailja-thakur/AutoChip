module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;
	reg [31:0] edge_detected;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			edge_detected <= (previous_in & ~in);
			
			// Keep the previous edge detected until reset
			out <= out | edge_detected;
		end
	end

endmodule
