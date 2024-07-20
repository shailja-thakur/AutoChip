module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

	always @(*)
	begin
		case(y)
			3'b000: begin
				if(w)
					Y2 = 1'b1;
				else
					Y2 = 1'b0;
			end
			
			3'b001: Y2 = 1'b1;
			
			3'b010: begin
				if(w)
					Y2 = 1'b1;
				else
					Y2 = 1'b0;
			end
			
			3'b011: Y2 = 1'b0;
			
			3'b100: Y2 = 1'b0;
			
			3'b101: Y2 = 1'b0;
			
			default: Y2 = 1'b0;
		endcase
	end
	
endmodule
