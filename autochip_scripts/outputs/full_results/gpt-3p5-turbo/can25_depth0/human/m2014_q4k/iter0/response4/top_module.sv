module top_module (
	input clk,
	input resetn,
	input in,
	output out
);
	reg [3:0] d_reg;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			d_reg <= 4'b0;
		end else begin
			d_reg <= {d_reg[2:0], in};
		end
	end
	
	assign out = d_reg[0];
endmodule
