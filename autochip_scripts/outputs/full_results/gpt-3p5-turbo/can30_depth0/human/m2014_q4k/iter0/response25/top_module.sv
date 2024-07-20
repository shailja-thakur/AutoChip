module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	
	reg [3:0] reg;

	always @(posedge clk) begin
		if (resetn == 0) begin
			reg <= 4'b0;
		end else begin
			reg <= {reg[2:0], in};
		end
	end

	assign out = reg[3];

endmodule
