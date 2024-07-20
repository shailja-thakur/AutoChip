module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	reg [2:0] state;

	parameter S0 = 3'b000; // Initial state
	parameter S1 = 3'b001; // First 1 received
	parameter S2 = 3'b010; // First 0 after 1 received
	parameter S3 = 3'b011; // 6 consecutive 1s
	parameter S4 = 3'b100; // 7 or more consecutive 1s

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= S0; // Initial state
		end else begin
			case (state)
				S0: begin
					state <= (in) ? S1 : S0; // Transition to S1 if input is 1, remain in S0 otherwise
				end
				S1: begin
					state <= (in) ? S1 : S2; // Transition to S1 if input is 1, transition to S2 if input is 0
				end
				S2: begin
					state <= (in) ? S1 : S3; // Transition to S1 if input is 1, transition to S3 if input is 0
				end
				S3: begin
					if (in) begin
						state <= S3; // Remain in S3 if input is 1
					end else begin
						state <= S0; // Transition to S0 if input is 0
					end
				end
				S4: begin
					state <= S0; // Transition to S0 after error state
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (state)
			S0: begin
				disc <= 0; // No bit to discard
				flag <= 0; // Not a flag
				err <= 0; // No error
			end
			S1: begin
				disc <= 0; // No bit to discard
				flag <= 0; // Not a flag
				err <= 0; // No error
			end
			S2: begin
				disc <= 0; // No bit to discard
				flag <= 0; // Not a flag
				err <= 0; // No error
			end
			S3: begin
				disc <= 1; // Signal to discard bit
				flag <= 1; // Flag detected
				err <= 0; // No error
			end
			S4: begin
				disc <= 0; // No bit to discard
				flag <= 0; // Not a flag
				err <= 1; // Error detected
			end
		endcase
	end

endmodule
