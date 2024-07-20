module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

	reg Y1_reg;
	reg Y3_reg;

	always @ (y or w) begin
		case(y)
			6'b000001: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
				else begin
					Y1_reg = 1'b1;
					Y3_reg = 1'b0;
				end
			end
			
			6'b000010: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
				else begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
			end
			
			6'b000100: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
				else begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b1;
				end
			end
			
			6'b001000: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
				else begin
					Y1_reg = 1'b1;
					Y3_reg = 1'b0;
				end
			end
			
			6'b010000: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b1;
				end
				else begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
			end
			
			6'b100000: begin
				if (w == 1'b1) begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b1;
				end
				else begin
					Y1_reg = 1'b0;
					Y3_reg = 1'b0;
				end
			end
			
			default: begin
				Y1_reg = 1'b0;
				Y3_reg = 1'b0;
			end
		endcase
	end
	
	assign Y1 = Y1_reg;
	assign Y3 = Y3_reg;

endmodule
