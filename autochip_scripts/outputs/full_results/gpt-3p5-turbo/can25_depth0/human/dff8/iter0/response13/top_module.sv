module top_module(
	input wire clk,
	input wire [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_temp;
	always @(posedge clk)
	begin
		q_temp <= d;
		q <= q_temp;
	end

endmodule
