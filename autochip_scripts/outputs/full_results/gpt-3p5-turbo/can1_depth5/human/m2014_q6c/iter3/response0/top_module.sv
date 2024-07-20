module top_module (
	input [6:1] y,
	input w,
	output reg Y2,
	output reg Y4
);

	// State signals
	reg A, B, C, D, E, F;
	always @(*)
		case (y)
			6'b000001: begin
				A = 1'b1;
				B = 1'b0;
				C = 1'b0;
				D = 1'b0;
				E = 1'b0;
				F = 1'b0;
			end
			6'b000010: begin
				A = 1'b1;
				B = 1'b1;
				C = 1'b0;
				D = 1'b0;
				E = 1'b0;
				F = 1'b0;
			end
			6'b000100, 6'b110000: begin
				A = 1'b1;
				B = 1'b1;
				C = 1'b1;
				D = 1'b0;
				E = 1'b0;
				F = 1'b0;
			end
			6'b001000: begin
				A = 1'b1;
				B = 1'b1;
				C = 1'b1;
				D = 1'b1;
				E = 1'b0;
				F = 1'b0;
			end
			6'b010000: begin
				A = 1'b1;
				B = 1'b1;
				C = 1'b1;
				D = 1'b1;
				E = 1'b1;
				F = 1'b0;
			end
			6'b100000: begin
				A = 1'b0;
				B = 1'b0;
				C = 1'b1;
				D = 1'b1;
				E = 1'b0;
				F = 1'b1;
			end
			default: begin
				A = 1'b0;
				B = 1'b0;
				C = 1'b0;
				D = 1'b0;
				E = 1'b0;
				F = 1'b0;
			end
		endcase

	// Next-state logic
	always @(posedge w or posedge y)
		if (w) begin
			case (y)
				6'b000001: begin
					Y2 <= 1'b0;
					Y4 <= 1'b1;
				end
				6'b000010: begin
					Y2 <= 1'b0;
					Y4 <= 1'b0;
				end
				6'b000100, 6'b110000: begin
					Y2 <= 1'b0;
					Y4 <= 1'b0;
				end
				6'b001000: begin
					Y2 <= 1'b1;
					Y4 <= 1'b0;
				end
				6'b010000: begin
					Y2 <= 1'b0;
					Y4 <= 1'b0;
				end
				6'b100000: begin
					Y2 <= 1'b1;
					Y4 <= 1'b1;
				end
				default: begin
					Y2 <= 1'b0;
					Y4 <= 1'b0;
				end
			endcase
		end

endmodule
