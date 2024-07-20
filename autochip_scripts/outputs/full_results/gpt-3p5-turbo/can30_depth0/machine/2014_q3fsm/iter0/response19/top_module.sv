module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

	reg [3:0] state, next_state;

	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter S10 = 3;
	parameter S11 = 4;
	parameter S20 = 5;
	parameter S21 = 6;
	parameter S22 = 7;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	always @(state or s or w) begin
		case (state)
			A: begin
				if (s) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (w) begin
					next_state = S11;
				end else begin
					next_state = S10;
				end
			end
			C: begin
				if (w) begin
					next_state = S11;
				end else begin
					next_state = S10;
				end
			end
			S10: begin
				if (w) begin
					next_state = S21;
				end else begin
					next_state = S20;
				end
			end
			S11: begin
				if (w) begin
					next_state = S22;
				end else begin
					next_state = S21;
				end
			end
			S20: begin
				next_state = B;
			end
			S21: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = B;
				end
			end
			S22: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = C;
				end
			end
			default: next_state = A;
		endcase
	end

	always @(posedge clk) begin
		case (state)
			A: begin
				// Add your code here for state A
			end
			B: begin
				// Add your code here for state B
			end
			C: begin
				// Add your code here for state C
			end
			S10: begin
				// Add your code here for state S10
			end
			S11: begin
				// Add your code here for state S11
			end
			S20: begin
				// Add your code here for state S20
			end
			S21: begin
				// Add your code here for state S21
			end
			S22: begin
				// Add your code here for state S22
			end
			default: begin
				// Add your code here for default state
			end
		endcase
	end

	always @(posedge clk) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (state)
				A: begin
					// Add your code here for state A output
				end
				B: begin
					// Add your code here for state B output
				end
				C: begin
					// Add your code here for state C output
				end
				S10: begin
					// Add your code here for state S10 output
				end
				S11: begin
					// Add your code here for state S11 output
				end
				S20: begin
					// Add your code here for state S20 output
				end
				S21: begin
					// Add your code here for state S21 output
				end
				S22: begin
					// Add your code here for state S22 output
				end
				default: begin
					// Add your code here for default state output
				end
			endcase
		end
	end

endmodule
