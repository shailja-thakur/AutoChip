module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State declaration
	typedef enum logic [1:0] {OFF, ON} state;
	reg[state] current_state, next_state;

	// Synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			current_state <= OFF;
		end else begin
			current_state <= next_state;
		end
	end

	// State transition logic
	always_comb begin
		case (current_state)
			OFF: begin
				if (j) begin
					next_state = ON;
				end else begin
					next_state = OFF;
				end
			end
			ON: begin
				if (k) begin
					next_state = OFF;
				end else begin
					next_state = ON;
				end
			end
		endcase
	end

	// Output assignment
	always @(current_state) begin
		case (current_state)
			OFF: begin
				out = 0;
			end
			ON: begin
				out = 1;
			end
		endcase
	end

endmodule
