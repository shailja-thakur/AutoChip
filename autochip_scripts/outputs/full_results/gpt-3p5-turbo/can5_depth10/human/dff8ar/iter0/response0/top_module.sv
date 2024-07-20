module top_module (
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q
);

	reg [7:0] q_reg;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			q_reg <= 8'b0;
		else
			q_reg <= d;
	end

	assign q = q_reg;

endmodule
