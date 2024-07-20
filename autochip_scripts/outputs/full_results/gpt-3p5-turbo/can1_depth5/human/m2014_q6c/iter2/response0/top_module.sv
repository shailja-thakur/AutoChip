module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	// State signals
	wire A, B, C, D, E, F;
	assign A = (y == 6'b000001);
	assign B = (y == 6'b000010);
	assign C = (y == 6'b000100);
	assign D = (y == 6'b001000);
	assign E = (y == 6'b010000);
	assign F = (y == 6'b100000);

	// Next-state logic
	always @(*) begin
		case (y)
			6'b000001: begin
				if (w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
				Y4 = 1'b1;
			end
			6'b000010: begin
				if (w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b000100: begin
				if (w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b001000: begin
				if (w)
					Y2 = 1'b1;
				else
					Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b010000: begin
				if (w)
					Y2 = 1'b0;
				else
					Y2 = 1'b1;
				Y4 = 1'b0;
			end
			6'b100000: begin
				if (w)
					Y2 = 1'b1;
				else
					Y2 = 1'b1;
				Y4 = 1'b1;
			end
		endcase
	end

endmodule
