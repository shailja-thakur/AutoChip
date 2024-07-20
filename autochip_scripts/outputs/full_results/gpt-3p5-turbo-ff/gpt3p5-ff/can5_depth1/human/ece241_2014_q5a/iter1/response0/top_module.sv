module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

reg [7:0] count;
reg [7:0] x_reg;
reg [7:0] z_reg;
reg areset_d;
reg x_d;

parameter WAIT_STATE = 0;
parameter CONVERSION_STATE = 1;

parameter [7:0] conversion_mask = 8'b11111111;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		count <= 0;
		x_reg <= 0;
		z_reg <= 0;
		areset_d <= 1'b1;
		x_d <= 1'b0;
		z <= 0;
	end
	else begin
		areset_d <= 1'b0;
		x_d <= x;
		
		if (count >= 7) begin
			x_reg <= {x_reg[6:0], x_d};
			z_reg <= ~(x_reg) + 1;
			count <= 0;
			z <= z_reg;
		end
		else begin
			x_reg <= {x_reg[6:0], x_d};
			count <= count + 1;
			z <= z_reg;
		end
	end
end

endmodule
