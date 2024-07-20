module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// State flip-flop assignments
reg F0, F1, F2, F3, F4, F5;

// Next state logic
always @(y, w)
begin
	case (y)
		6'b000001: 
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b1;
				F1 <= 1'b1;
				F2 <= 1'b1;
				F3 <= 1'b1;
				F4 <= 1'b1;
				F5 <= 1'b1;
			end
			else
			begin
				F0 <= 1'b1;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b0;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
		end
		
		6'b000010:
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b0;
				F1 <= 1'b1;
				F2 <= 1'b1;
				F3 <= 1'b1;
				F4 <= 1'b1;
				F5 <= 1'b1;
			end
			else
			begin
				F0 <= 1'b0;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b1;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
		end
		
		6'b000100:
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b0;
				F1 <= 1'b0;
				F2 <= 1'b1;
				F3 <= 1'b1;
				F4 <= 1'b1;
				F5 <= 1'b1;
			end
			else
			begin
				F0 <= 1'b0;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b0;
				F4 <= 1'b1;
				F5 <= 1'b0;
			end
		end
		
		6'b001000:
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b0;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b1;
				F4 <= 1'b0;
				F5 <= 1'b1;
			end
			else
			begin
				F0 <= 1'b1;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b0;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
		end
		
		6'b010000:
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b0;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b0;
				F4 <= 1'b0;
				F5 <= 1'b1;
			end
			else
			begin
				F0 <= 1'b1;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b1;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
		end
		
		6'b100000:
		begin
			if (w == 1'b1)
			begin
				F0 <= 1'b1;
				F1 <= 1'b1;
				F2 <= 1'b1;
				F3 <= 1'b1;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
			else
			begin
				F0 <= 1'b1;
				F1 <= 1'b0;
				F2 <= 1'b0;
				F3 <= 1'b0;
				F4 <= 1'b0;
				F5 <= 1'b0;
			end
		end
		
		default:
		begin
			F0 <= 1'b0;
			F1 <= 1'b0;
			F2 <= 1'b0;
			F3 <= 1'b0;
			F4 <= 1'b0;
			F5 <= 1'b0;
		end
	endcase
end

// Output assignments
assign Y1 = F1;
assign Y3 = F3;

endmodule
