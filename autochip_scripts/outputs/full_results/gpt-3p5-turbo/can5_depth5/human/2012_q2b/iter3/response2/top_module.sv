module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg [5:0] Y_reg;

	always @(posedge w) begin
		case (y)
			6'b000001: Y_reg <= 6'b000010;
			6'b000010: Y_reg <= 6'b000001;
			6'b000100: Y_reg <= 6'b000010;
			6'b001000: Y_reg <= 6'b001000;
			6'b010000: Y_reg <= 6'b010000;
			6'b100000: Y_reg <= 6'b010000;
			default: Y_reg <= 6'b000000;
		endcase
	end
	
	assign Y1 = Y_reg[1];
	assign Y3 = Y_reg[3];
	
endmodule
