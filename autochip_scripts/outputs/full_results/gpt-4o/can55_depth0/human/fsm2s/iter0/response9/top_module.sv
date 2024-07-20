module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	localparam OFF = 1'b0, ON = 1'b1;
	reg state, next_state;

	// State transition logic
	always @(*) begin
		case (state)
			OFF: next_state = j ? ON : OFF;
			ON:  next_state = k ? OFF : ON;
			default: next_state = OFF;
		endcase
	end

	// State flip-flops with synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end
	
	// Output logic
	always @(*) begin
		case (state)
			OFF: out = 1'b0;
			ON:  out = 1'b1;
			default: out = 1'b0;
		endcase
	end

endmodule
