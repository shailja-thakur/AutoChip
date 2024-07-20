module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1;
reg Y3;

always @(*) begin
	case(y)
		6'b0_00001: begin
			Y1 = 1'b0;
			Y3 = 1'b0;
		end
		
		6'b0_00010: begin
			Y1 = 1'b1;
			Y3 = 1'b0;
		end
		
		6'b0_00100: begin
			Y1 = 1'b0;
			Y3 = 1'b0;
		end
		
		6'b0_01000: begin
			Y1 = 1'b0;
			Y3 = 1'b1;
		end
		
		6'b0_10000: begin
			Y1 = 1'b1;
			Y3 = 1'b0;
		end
		
		6'b1_00000: begin
			Y1 = 1'b1;
			Y3 = 1'b1;
		end
	endcase
end

endmodule
