module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	localparam OFF = 1'b0;
	localparam ON = 1'b1;

	// State registers
	reg state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			OFF: begin
				if (j)
					next_state = ON;
				else
					next_state = OFF;
			end
			ON: begin
				if (k)
					next_state = OFF;
				else
					next_state = ON;
			end
			default: next_state = OFF;
		endcase
	end

	// Sequential state update logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(state) begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
			default: out = 0;
		endcase
	end

endmodule
