module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	reg Y2, Y4; // Registers to hold the next-state signals

	always @(y or w)
	begin
		// Logic equations for Y2
		if (w == 0) begin
			case (y)
				6'b000001: Y2 = 0;
				6'b000010: Y2 = 0;
				6'b000100: Y2 = 1;
				6'b001000: Y2 = 1;
				6'b010000: Y2 = 0;
				6'b100000: Y2 = 1;
				default: Y2 = 0;
			endcase
		end
		else begin
			case (y)
				6'b000001: Y2 = 0;
				6'b000010: Y2 = 0;
				6'b000100: Y2 = 1;
				6'b001000: Y2 = 1;
				6'b010000: Y2 = 0;
				6'b100000: Y2 = 1;
				default: Y2 = 1;
			endcase
		end

		// Logic equations for Y4
		if (w == 0) begin
			case (y)
				6'b000001: Y4 = 1;
				6'b000010: Y4 = 0;
				6'b000100: Y4 = 0;
				6'b001000: Y4 = 0;
				6'b010000: Y4 = 0;
				6'b100000: Y4 = 0;
				default: Y4 = 0;
			endcase
		end
		else begin
			case (y)
				6'b000001: Y4 = 1;
				6'b000010: Y4 = 0;
				6'b000100: Y4 = 0;
				6'b001000: Y4 = 0;
				6'b010000: Y4 = 0;
				6'b100000: Y4 = 1;
				default: Y4 = 1;
			endcase
		end
	end

endmodule
