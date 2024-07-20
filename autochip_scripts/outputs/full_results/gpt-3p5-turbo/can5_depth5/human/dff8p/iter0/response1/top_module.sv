module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q
);
	reg [7:0] q_temp;

	always @(negedge clk or posedge reset) begin
		if (reset) begin
			q_temp <= 8'b00110100;
		end else begin
			q_temp <= d;
		end
	end

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 8'b00110100;
		end else begin
			q <= q_temp;
		end
	end
endmodule
