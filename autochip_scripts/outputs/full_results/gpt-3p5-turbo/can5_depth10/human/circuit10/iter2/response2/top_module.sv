module top_module (
	input clk,
	input a,
	input b,
	output reg q,
	output reg state
);

reg [1:0] state_reg;
always @(posedge clk) begin
	state_reg <= a & ~b;
	q <= state_reg[1];
	state <= state_reg[0];
end

endmodule
