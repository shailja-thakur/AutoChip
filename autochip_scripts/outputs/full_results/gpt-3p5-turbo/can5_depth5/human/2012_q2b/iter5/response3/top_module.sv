module top_module (
	input [5:0] y,
	input w,
	output reg Y1,
	output reg Y3
);

	reg [5:0] Y_reg;
	
	always @(posedge w or y) begin
		case (y)
			6'b000001: Y_reg <= 6'b000010;
			6'b000010: Y_reg <= 6'b000001;
			6'b000100: Y_reg <= 6'b001000;
			6'b001000: Y_reg <= 6'b010000;
			6'b010000: Y_reg <= 6'b100000;
			6'b100000: Y_reg <= 6'b000100; 
			default: Y_reg <= 6'b000000;
		endcase
	end
	
	always @(posedge w or y) begin
		case (Y_reg)
			6'b000001: begin Y1 <= 1'b0; Y3 <= 1'b1; end
			6'b000010: begin Y1 <= 1'b1; Y3 <= 1'b0; end
			6'b000100: begin Y1 <= 1'b0; Y3 <= 1'b1; end
			6'b001000: begin Y1 <= 1'b0; Y3 <= 1'b0; end
			6'b010000: begin Y1 <= 1'b0; Y3 <= 1'b0; end
			6'b100000: begin Y1 <= 1'b1; Y3 <= 1'b0; end
			default: begin Y1 <= 1'b0; Y3 <= 1'b0; end
		endcase
	end
	
endmodule
