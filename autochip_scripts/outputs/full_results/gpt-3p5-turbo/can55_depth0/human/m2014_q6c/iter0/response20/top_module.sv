module top_module (
	input [6:1] y,
	input w,
	output Y2,
	output Y4
);

	reg Y2;
	reg Y4;

	always @(y, w) begin
		case (y)
			6'b000001: begin
				if (w == 0) begin
					Y2 = 0;
					Y4 = 0;
				end else begin
					Y2 = 0;
					Y4 = 0;
				end
			end
			6'b000010: begin
				if (w == 0) begin
					Y2 = 1;
					Y4 = 1;
				end else begin
					Y2 = 1;
					Y4 = 0;
				end
			end
			6'b000100: begin
				if (w == 0) begin
					Y2 = 0;
					Y4 = 0;
				end else begin
					Y2 = 1;
					Y4 = 1;
				end
			end
			6'b001000: begin
				if (w == 0) begin
					Y2 = 0;
					Y4 = 1;
				end else begin
					Y2 = 0;
					Y4 = 0;
				end
			end
			6'b010000: begin
				if (w == 0) begin
					Y2 = 0;
					Y4 = 0;
				end else begin
					Y2 = 0;
					Y4 = 1;
				end
			end
			6'b100000: begin
				if (w == 0) begin
					Y2 = 1;
					Y4 = 0;
				end else begin
					Y2 = 0;
					Y4 = 0;
				end
			end
		endcase
	end

endmodule
