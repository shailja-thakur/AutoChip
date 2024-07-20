module top_module (
	input [5:0] y,
	input w,
	output Y1,
	output Y3
);

// Define the state machine combinational logic
always @(*)
begin
	case(y)
		6'b000001:	// State A
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b0;
					Y3 = 1'b0;
				end
				else
				begin
					Y1 = 1'b1;
					Y3 = 1'b0;
				end
			end

		6'b000010:	// State B
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b1;
					Y3 = 1'b0;
				end
				else
				begin
					Y1 = 1'b0;
					Y3 = 1'b0;
				end
			end

		6'b000100:	// State C
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b0;
					Y3 = 1'b1;
				end
				else
				begin
					Y1 = 1'b1;
					Y3 = 1'b0;
				end
			end

		6'b001000:	// State D
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b1;
					Y3 = 1'b0;
				end
				else
				begin
					Y1 = 1'b0;
					Y3 = 1'b0;
				end
			end

		6'b010000:	// State E
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b0;
					Y3 = 1'b0;
				end
				else
				begin
					Y1 = 1'b1;
					Y3 = 1'b1;
				end
			end

		6'b100000:	// State F
			begin
				if (w == 1'b1)
				begin
					Y1 = 1'b1;
					Y3 = 1'b1;
				end
				else
				begin
					Y1 = 1'b0;
					Y3 = 1'b0;
				end
			end

		default:
			begin
				Y1 = 1'bx;
				Y3 = 1'bx;
			end
	endcase
end

endmodule
