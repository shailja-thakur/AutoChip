module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	// State register and next state logic
	reg [1:0] state, next_state;
	
	// Output logic
	assign out = (state == 2'b10) ? 1'b1 : 1'b0;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 2'b00; // Initialize to state A
		end else begin
			state <= next_state;
		end
	end
	
	always @(state, j, k) begin
		case (state)
			2'b00: begin // State A
				if (j) begin
					next_state = 2'b01; // Transition to state B if j is high
				end else begin
					next_state = 2'b00; // Remain in state A if j is low
				end
			end
			
			2'b01: begin // State B
				if (k) begin
					next_state = 2'b00; // Transition to state A if k is high
				end else begin
					next_state = 2'b01; // Remain in state B if k is low
				end
			end
			
			default: begin // Invalid state
				next_state = 2'b00; // Reset to state A
			end
		endcase
	end
endmodule
