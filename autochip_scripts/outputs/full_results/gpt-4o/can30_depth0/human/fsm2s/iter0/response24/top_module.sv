module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum logic [1:0] {
		OFF = 2'b00,
		ON  = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			OFF: begin
				if (j) next_state = ON;
				else next_state = OFF;
			end

			ON: begin
				if (k) next_state = OFF;
				else next_state = ON;
			end

			default: next_state = OFF; // default state for safety
		endcase
	end

	// Sequential logic for state transitions
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Output logic
	always @(posedge clk) begin
		if (reset) begin
			out <= 1'b0;
		end else begin
			case (state)
				OFF: out <= 1'b0;
				ON:  out <= 1'b1;
				default: out <= 1'b0; // default output for safety
			endcase
		end
	end

endmodule
