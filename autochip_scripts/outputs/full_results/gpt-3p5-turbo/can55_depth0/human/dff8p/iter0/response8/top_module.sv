module top_module(
	input clk,
	input [7:0] d,
	input reset,
	output reg [7:0] q);

reg [7:0] q_reg;
always @(posedge clk or negedge reset) begin
	if (reset == 1'b0)
		q_reg <= 8'b00110100;
	else begin
		q_reg <= d;
	end
end

assign q = q_reg;

endmodule
