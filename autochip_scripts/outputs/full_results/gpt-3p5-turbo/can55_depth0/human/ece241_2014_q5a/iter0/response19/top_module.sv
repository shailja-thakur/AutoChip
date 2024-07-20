module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg state;
reg z_reg;
reg x_reg;

parameter S0 = 1'b0;
parameter S1 = 1'b1;

always @(posedge clk or negedge areset) begin
	if (areset == 0)
		state <= S0;
	else
		state <= S1;
end

always @(posedge clk or negedge areset) begin
	if (areset == 0)
		x_reg <= 1'b0;
	else
		x_reg <= x;
end

always @(posedge clk or negedge areset) begin
	if (areset == 0)
		z_reg <= 1'b0;
	else if (state == S1)
		z_reg <= ~x_reg + 1'b1;
	else
		z_reg <= 1'b0;
end

assign z = z_reg;

endmodule
