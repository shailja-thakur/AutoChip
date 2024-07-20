module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

reg Y1, Y3;

always @(posedge w) begin
	case (y)
		6'b000001: begin 
			Y1 <= 0;
			Y3 <= 0;
		end
		6'b000010: begin 
			Y1 <= 0;
			Y3 <= 1;
		end
		6'b000100: begin 
			Y1 <= 1;
			Y3 <= 0;
		end
		6'b001000: begin 
			Y1 <= 1;
			Y3 <= 1;
		end
		6'b010000: begin 
			Y1 <= 0;
			Y3 <= 1;
		end
		6'b100000: begin 
			Y1 <= 1;
			Y3 <= 0;
		end
	endcase
end

endmodule
