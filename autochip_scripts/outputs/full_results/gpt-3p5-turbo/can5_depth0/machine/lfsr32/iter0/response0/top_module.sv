module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal registers
	reg [31:0] q_next;

	// Initial value of q register
	reg [31:0] initial_value = 32'h1;
	
	always @(posedge clk) begin
		// Reset check
		if (reset) begin
			q <= initial_value;
		end else begin
			q <= q_next;
		end
	end

	// Next value of q register
	always @* begin
		q_next[0] = q[31] ^ q[21] ^ q[1];
		q_next[31:1] = q[30:0];
	end
	
endmodule
