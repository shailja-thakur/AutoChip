module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state;
parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	end else begin
		case(state)
			A: begin
				if (s) begin
					state <= B;
				end
			end
			B: begin
				if (w) begin
					state <= S11;
				end else begin
					state <= S10;
				end
			end
			C: begin
				if (w) begin
					state <= S11;
				end else begin
					state <= S10;
				end
			end
			S10: begin
				if (w) begin
					state <= S21;
				end else begin
					state <= S20;
				end
			end
			S11: begin
				if (w) begin
					state <= S22;
				end else begin
					state <= S21;
				end
			end
			S20: begin
				state <= B;
			end
			S21: begin
				if (w) begin
					state <= C;
				end else begin
					state <= B;
				end
			end
			S22: begin
				if (w) begin
					state <= B;
				end else begin
					state <= C;
				end
			end
		endcase
	end
end

always @(state) begin
	case(state)
		B, C, S10, S11, S20, S21: begin
			z = 1'b1;
		end
		default: begin
			z = 1'b0;
		end
	endcase
end

endmodule
