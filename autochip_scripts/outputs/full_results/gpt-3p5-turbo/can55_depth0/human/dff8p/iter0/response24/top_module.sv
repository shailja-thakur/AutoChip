module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

	reg [7:0] q_next;
	always @(negedge clk or posedge reset) begin
		if (reset) begin
			q <= 8'b00110100;
		end else begin
			q <= q_next;
		end
	end

	always @(negedge clk) begin
		q_next <= d;
	end

endmodule
