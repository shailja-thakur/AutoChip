module top_module (
	input clk,
	input reset,
	input w,
	output z
);

// State enumeration
typedef enum logic [2:0] {
	A, B, C, D, E, F
} state_t;

// State register
reg [2:0] state_reg;

// Next state logic
always @(posedge clk or posedge reset) begin
	if (reset) begin
		state_reg <= A;
	end else begin
		case (state_reg)

			A: begin
				if (w) begin
					state_reg <= B;
				end else begin
					state_reg <= A;
				end
			end

			B: begin
				if (w) begin
					state_reg <= C;
				end else begin
					state_reg <= D;
				end
			end

			C: begin
				if (w) begin
					state_reg <= E;
				end else begin
					state_reg <= D;
				end
			end

			D: begin
				if (w) begin
					state_reg <= F;
				end else begin
					state_reg <= A;
				end
			end

			E: begin
				if (w) begin
					state_reg <= E;
				end else begin
					state_reg <= D;
				end
			end

			F: begin
				if (w) begin
					state_reg <= C;
				end else begin
					state_reg <= D;
				end
			end

		endcase
	end
end

// Output logic
always @(state_reg) begin
	case (state_reg)

		A: begin
			z = 0;
		end

		B: begin
			z = 0;
		end

		C: begin
			z = 0;
		end

		D: begin
			z = 0;
		end

		E: begin
			z = 1;
		end

		F: begin
			z = 1;
		end

	endcase
end

endmodule
