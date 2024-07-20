module top_module (
	input clk,
	input resetn,
	input in,
	output out
);

	reg [3:0] reg;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			reg <= 4'b0000;
		end else begin
			reg <= {reg[2:0], in};
		end
	end

	assign out = reg[3];

endmodule
