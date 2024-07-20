module top_module (
	input clk,
	input d,
	input ar,
	output logic q
);
	reg q_reg;
	always @(posedge clk or posedge ar) begin
		if (ar)
			q_reg <= 1'b0;
		else
			q_reg <= d;
	end
	assign q = q_reg;
endmodule
