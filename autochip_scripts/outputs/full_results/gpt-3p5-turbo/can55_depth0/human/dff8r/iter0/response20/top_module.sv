module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	// Declare flip-flop instances
	reg [7:0] q_temp;
	reg [7:0] q_next;

	always @(posedge clk) begin
		if (reset) begin
			q_temp <= 8'b0; // Reset to zero
		end else begin
			q_temp <= q_next; // Store next state
		end
	end

	always @* begin
		q_next = d; // Update next state
	end

	assign q = q_temp;

endmodule
