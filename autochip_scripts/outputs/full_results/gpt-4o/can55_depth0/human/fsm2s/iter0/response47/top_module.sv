module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// State encoding
	typedef enum reg [1:0] {
		OFF = 2'b00,
		ON = 2'b01
	} state_t;

	state_t state, next_state;

	// State transition
	always @(posedge clk) begin
		if (reset) begin
			state <= OFF;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			OFF: if (j) 
					next_state = ON;
				 else 
					next_state = OFF;
				 
			ON: if (k) 
					next_state = OFF;
				else 
					next_state = ON;
		endcase
	end

	// Output logic
	always @(*) begin
		case (state)
			OFF: out = 0;
			ON: out = 1;
		endcase
	end

endmodule
