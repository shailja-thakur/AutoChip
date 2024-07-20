module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states
	typedef enum logic[2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_type;

	// Define registers
	reg state_type state;

	// Combinational logic block for state transitions
	always_comb begin
		case (state)
			S: begin
				if (data) begin
					state <= S1;
				end else begin
					state <= S;
				end
			end
			S1: begin
				if (data) begin
					state <= S11;
				end else begin
					state <= S;
				end
			end
			S11: begin
				if (data) begin
					state <= S11;
				end else begin
					state <= S110;
				end
			end
			S110: begin
				if (data) begin
					state <= Done;
				end else begin
					state <= S;
				end
			end
			Done: begin
				state <= Done;
			end
			default: state <= S;
		endcase
	end

	// Assign output based on current state
	assign start_shifting = (state == Done) ? 1'b1 : 1'b0;

	// Reset state on rising edge of reset signal
	always_ff @(posedge reset) begin
		state <= S;
	end

	// Update state on rising edge of clk signal
	always_ff @(posedge clk) begin
		state <= next_state;
	end
endmodule
