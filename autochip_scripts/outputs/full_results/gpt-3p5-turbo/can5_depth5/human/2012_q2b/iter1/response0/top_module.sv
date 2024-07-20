module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg [5:0] y_reg;
	reg [5:0] y_next;

	always @(posedge w) begin
		y_reg <= y_next;
		y_next <= y;
		
		case (y_reg)
			6'b000001: begin
				Y1 <= 1'b0;
				Y3 <= 1'b0;
			end
			
			6'b000010: begin
				Y1 <= 1'b0;
				Y3 <= 1'b0;
			end
			
			6'b000100: begin
				Y1 <= 1'b0;
				Y3 <= 1'b1;
			end
			
			6'b001000: begin
				Y1 <= 1'b0;
				Y3 <= 1'b1;
			end
			
			6'b010000: begin
				Y1 <= 1'b1;
				Y3 <= 1'b0;
			end
			
			6'b100000: begin
				Y1 <= 1'b1;
				Y3 <= 1'b0;
			end
			
			default: begin
				Y1 <= 1'b0;
				Y3 <= 1'b0;
			end
		endcase
	end
	
endmodule
