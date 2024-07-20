module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	// Define state variables
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter S10 = 3;
	parameter S11 = 4;
	parameter S20 = 5;
	parameter S21 = 6;
	parameter S22 = 7;
	
	reg [2:0] state_reg;
	reg [2:0] next_state_reg;
	
	// Define state transition conditions
	
	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state_reg;
		end
	end
	
	// Define next state logic
	
	always @ (*) begin
		case (state_reg)
			A: begin
				if (s) begin
					next_state_reg = B;
				end else begin
					next_state_reg = state_reg;
				end
			end
			B: begin
				if (w) begin
					next_state_reg = S11;
				end else begin
					next_state_reg = S10;
				end
			end
			C: begin
				if (w) begin
					next_state_reg = S11;
				end else begin
					next_state_reg = S10;
				end
			end
			S10: begin
				if (w) begin
					next_state_reg = S21;
				end else begin
					next_state_reg = S20;
				end
			end
			S11: begin
				if (w) begin
					next_state_reg = S22;
				end else begin
					next_state_reg = S21;
				end
			end
			S20: begin
				next_state_reg = B;
			end
			S21: begin
				if (w) begin
					next_state_reg = C;
				end else begin
					next_state_reg = B;
				end
			end
			S22: begin
				if (w) begin
					next_state_reg = B;
				end else begin
					next_state_reg = C;
				end
			end
			default: next_state_reg = state_reg;
		endcase
	end
	
	// Define outputs
	
	always @ (posedge clk) begin
		if (reset) begin
			z <= 0;
		end else begin
			case (state_reg)
				S10, S11: z <= 1;
				default: z <= 0;
			endcase
		end
	end

endmodule
