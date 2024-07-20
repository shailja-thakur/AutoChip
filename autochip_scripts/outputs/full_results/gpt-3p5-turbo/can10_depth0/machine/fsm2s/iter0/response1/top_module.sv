module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= 2'b00; // Initialize state to A
		end else begin
			state <= next_state; // Transition to next state
		end
	end
	
	always @(state, j, k) begin
		case (state)
			2'b00: begin // State A
				if (j == 1'b1) begin
					next_state = 2'b01; // Transition to state B
				end else begin
					next_state = 2'b00; // Remain in state A
				end
			end
			
			2'b01: begin // State B
				if (k == 1'b1) begin
					next_state = 2'b00; // Transition to state A
				end else begin
					next_state = 2'b01; // Remain in state B
				end
			end
		endcase
	end
	
	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, low otherwise
	
endmodule
