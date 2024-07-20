module top_module(
	input clk,
	input reset,
	output shift_ena);
	reg [2:0] state; // define state variable
	reg [2:0] next_state; // define next_state variable
	assign shift_ena = (state == 3); //  shift_ena is high when state is 3
	always @(posedge clk) begin
		if (reset) begin
			state <= 0; // reset state to 0 when reset is active high
		end else begin
			state <= next_state; // update state with next state
		end
	end

	always @(state) begin
		case (state)
			0: begin
				// check for bit pattern
				if (/* condition for bit pattern detection */) begin
					next_state <= 1; // if bit pattern detected, transition to state 1
				end else begin
					next_state <= 0; // otherwise stay in state 0
				end
			end
			1: begin
				// check for bit pattern
				if (/* condition for bit pattern detection */) begin
					next_state <= 2; // if bit pattern detected, transition to state 2
				end else begin
					next_state <= 0; // otherwise go back to state 0
				end
			end
			2: begin
				// check for bit pattern
				if (/* condition for bit pattern detection */) begin
					next_state <= 3; // if bit pattern detected, transition to state 3
				end else begin
					next_state <= 0; // otherwise go back to state 0
				end
			end
			3: begin
				next_state <= 0; // reset to state 0 after 4 clock cycles
			end
		endcase
	end
endmodule
