module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg out_reg;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			out_reg <= 1'b0;
		end else begin
			out_reg <= in;
		end
	end

	assign out = out_reg;

endmodule
