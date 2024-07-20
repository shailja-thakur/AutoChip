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

	// Synchronous process for state transition
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Combinational process for next state logic
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

	// Output logic: since this is a Moore machine, output depends only on the state
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			out <= 1'b0;
		end else begin
			case (state)
				OFF: out <= 1'b0;
				ON: out <= 1'b1;
				default: out <= 1'b0;
			endcase
		end
	end

endmodule
