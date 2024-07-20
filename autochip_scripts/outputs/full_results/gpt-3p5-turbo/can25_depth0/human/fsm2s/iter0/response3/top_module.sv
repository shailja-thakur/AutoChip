module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	parameter OFF = 1'b0;
	parameter ON = 1'b1;

	reg state, next_state;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
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

	// Output logic
	always @(state) begin
		case (state)
			OFF: out = 1'b0;
			ON: out = 1'b1;
		endcase
	end

endmodule
