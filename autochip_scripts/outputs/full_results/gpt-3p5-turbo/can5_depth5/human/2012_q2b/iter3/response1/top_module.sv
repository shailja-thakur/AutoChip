module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg [5:0] Y_reg;

	always @(posedge w) begin
		Y_reg <= y;
	end
	
	assign Y1 = Y_reg[1];
	assign Y3 = Y_reg[3];
	
endmodule
