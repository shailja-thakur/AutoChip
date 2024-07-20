module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire reset,
	output reg [7:0] q);
	
	reg [7:0] q_temp;

	always @(posedge clk or negedge reset) begin
		if (!reset) begin
			q_temp <= 8'b00110100; // reset to 0x34
		end else begin
			q_temp <= d;
		end
	end

	always @(negedge clk) begin
		q <= q_temp;
	end

endmodule
