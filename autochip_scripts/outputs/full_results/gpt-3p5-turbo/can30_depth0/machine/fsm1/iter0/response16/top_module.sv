module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state; // Define state variables
	always @(posedge clk, posedge areset) begin // State update process
		if (areset) begin
			state <= 2'b1; // Reset state to B
		end else begin
			state <= next_state; // Update state
		end
	end
	
	always @(state, in) begin // Next state logic
		case (state)
			2'b00: begin // State A
				if (in) begin // Stay in state A if 'in' is high
					next_state = 2'b00;
				end else begin // Transition to state B if 'in' is low
					next_state = 2'b01;
				end
			end
			2'b01: begin // State B
				if (in) begin // Stay in state B if 'in' is high
					next_state = 2'b01;
				end else begin // Transition to state A if 'in' is low
					next_state = 2'b00;
				end
			end
		endcase
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output logic
	
endmodule
