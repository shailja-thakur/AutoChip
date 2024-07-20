module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define the states
	typedef enum logic [2:0] {
		S,
		S1,
		S11,
		S110,
		Done
	} state_t;

	reg state; // Register to hold the current state

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= S; // Reset to initial state on reset signal
		end else begin
			case (state)
				S: begin
					if (data) begin
						state <= S1;
					end else begin
						state <= S; // Stay in current state if data is low
					end
				end
				S1: begin
					if (data) begin
						state <= S11;
					end else begin
						state <= S; // Stay in current state if data is low
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
						state <= S; // Stay in current state if data is low
					end
				end
				Done: begin
					state <= Done;
				end
			endcase
		end
	end

	assign start_shifting = (state == Done) ? 1'b1 : 1'b0; // Output is high if state is Done, low otherwise

endmodule
