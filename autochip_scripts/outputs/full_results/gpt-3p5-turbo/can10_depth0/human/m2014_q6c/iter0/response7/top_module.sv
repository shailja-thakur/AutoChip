module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	reg Y2;
	reg Y4;

	always @(y or w) begin
		Y2 = (y == 6'b000010) | (y == 6'b001000) | (y == 6'b100000) | (w & (y == 6'b000100)); 
		Y4 = (y == 6'b000100) | (y == 6'b010000) | (y == 6'b100000) | (w & (y == 6'b000010) | (y == 6'b001000));	
	end	

endmodule
