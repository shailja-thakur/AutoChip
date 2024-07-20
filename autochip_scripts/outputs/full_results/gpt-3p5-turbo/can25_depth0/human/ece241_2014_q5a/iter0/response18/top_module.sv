module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [31:0] shift_reg;
	reg [31:0] comp_reg;
	reg z;

	always @(posedge clk or negedge areset) begin
		if (areset) begin
			shift_reg <= 0;
			comp_reg <= 0;
			z <= 0;
		end else begin
			shift_reg <= {shift_reg[30:0], x};
			comp_reg <= ~shift_reg + 1;
			z <= comp_reg[0];
		end
	end

endmodule
