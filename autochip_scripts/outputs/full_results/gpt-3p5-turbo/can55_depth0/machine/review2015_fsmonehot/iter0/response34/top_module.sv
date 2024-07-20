module top_module(
    input d,
    input done_counting,
    input ack,
    input [9:0] state,    // 10-bit one-hot current state
    output reg B3_next,
    output reg S_next,
    output reg S1_next,
    output reg Count_next,
    output reg Wait_next,
    output done,
    output counting,
    output shift_ena
 );

	reg [9:0] state_next;
	
	always @(*) begin
		case (state)
			// State transitions and output actions for each state
			// S
			10'b0000000001 : begin
				if (d == 0 || state[0] == 0) begin
					S_next = 1;
				end else begin
					S_next = 0;
				end
			end
			// S1
			10'b0000000010 : begin
				if (d == 0 || state[0] == 0 || state[1] == 1) begin
					S1_next = 1;
				end else begin
					S1_next = 0;
				end
			end
			// S11
			10'b0000000110 : begin
				// No specific conditions mentioned for this state
			end
			// S110
			10'b0000001100 : begin
				if (d == 0) begin
					S_next = 1;
				end else begin
					S_next = 0;
				end
			end
			// B0
			10'b0000010000 : begin
				shift_ena = 1;
			end
			// B1
			10'b0000100000 : begin
				shift_ena = 1;
			end
			// B2
			10'b0001000000 : begin
				shift_ena = 1;
				B3_next = 1;
			end
			// B3
			10'b0010000000 : begin
				shift_ena = 1;
			end
			// Count
			10'b0100000000 : begin
				if (done_counting == 0 || state[7] == 0) begin
					Count_next = 1;
				end else begin
					Count_next = 0;
				end
			end
			// Wait
			10'b1000000000 : begin
				if (ack == 0 || state[9] == 0) begin
					Wait_next = 1;
				end else begin
					Wait_next = 0;
				end
			end
			default : begin
				// Default case
			end
		endcase
	end

	always @(posedge clk) begin
		state <= state_next;
	end

	always @(state) begin
		case (state)
			// Done signal
			10'b1000000000 : begin
				done = 1;
			end
			default : begin
				done = 0;
			end
		endcase

		case (state)
			// Counting signal
			10'b0100000000 : begin
				counting = 1;
			end
			default : begin
				counting = 0;
			end
		endcase

		case (state)
			// Shift enable signal
			10'b0000100XXX : begin
				shift_ena = 1;
			end
			default : begin
				shift_ena = 0;
			end
		endcase
	end
endmodule
