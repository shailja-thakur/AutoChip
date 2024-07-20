module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] shift_reg;

	assign out = shift_reg[3];

	always @(posedge clk) begin
		if (!resetn)
			shift_reg <= 4'b0000;
		else
			shift_reg <= {shift_reg[2:0], in};
	end

endmodule
