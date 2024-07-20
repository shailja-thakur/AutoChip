module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
	
	// Next state logic
	always @(*) begin
		case(y)
			3'b000: begin
				if(w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
			end
			3'b001, 3'b011: begin
				Y2 = 1'b0;
			end
			3'b010, 3'b110: begin
				Y2 = 1'b1;
			end
			3'b100: begin
				if(w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
			end
			3'b101: begin
				Y2 = 1'b1;
			end
			default: begin
				Y2 = 1'b0;
			end
		endcase
	end
	
endmodule
