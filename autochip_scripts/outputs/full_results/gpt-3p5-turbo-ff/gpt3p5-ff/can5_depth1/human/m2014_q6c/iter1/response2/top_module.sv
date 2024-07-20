module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);
	reg [6:1] y_reg;
	wire a_next, b_next, c_next, d_next, e_next, f_next;
	always @(posedge w or posedge y[1] or posedge y[2] or posedge y[3] or posedge y[4] or posedge y[5] or posedge y[6]) begin
		y_reg <= y;
	end
	
	assign a_next = y_reg[1] & ~y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | y_reg[1] & y_reg[2] & y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6];
	assign b_next = ~y_reg[1] & ~y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | y_reg[1] & ~y_reg[2] & ~y_reg[3] & y_reg[4] & ~y_reg[5] & ~y_reg[6];
	assign c_next = ~y_reg[1] & y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | ~y_reg[1] & ~y_reg[2] & ~y_reg[3] & y_reg[4] & ~y_reg[5] & ~y_reg[6];
	assign d_next = ~y_reg[1] & y_reg[2] & ~y_reg[3] & y_reg[4] & ~y_reg[5] & ~y_reg[6] | y_reg[1] & y_reg[2] & y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | ~y_reg[1] & ~y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | y_reg[1] & ~y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6];
	assign e_next = ~y_reg[1] & ~y_reg[2] & y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6] | ~y_reg[1] & y_reg[2] & ~y_reg[3] & ~y_reg[4] & ~y_reg[5] & ~y_reg[6];
	assign f_next = ~y_reg[1] & y_reg[2] & ~y_reg[3] & ~y_reg[4] & y_reg[5] & ~y_reg[6] | ~y_reg[1] & ~y_reg[2] & ~y_reg[3] & y_reg[4] & y_reg[5] & ~y_reg[6];
	
	assign Y2 = y_reg[2] & ~w | a_next & w;
	assign Y4 = y_reg[4] & ~w | c_next & w;
endmodule
