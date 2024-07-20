module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum reg [2:0] {
		S0, // Initial state or after seeing 0
		S1, // Seen 1
		S11, // Seen 11
		S111, // Seen 111
		S1111, // Seen 1111
		S11111, // Seen 11111
		S111110, // Seen 111110
		S111111 // Seen 111111 (error state)
	} state_t;

	state_t current_state, next_state;

	// Sequential state transition
	always @(posedge clk) begin
        if (reset) begin
			current_state <= S0;
			disc <= 0;
			flag <= 0;
			err <= 0;
		end else begin
			current_state <= next_state;
			// Outputs are delayed by one clock cycle following the states
			case (current_state)
				S11111: disc <= in ? 0 : 1; // disc if we see 0111110
				S111110: flag <= in ? 1 : 0; // flag if we see 01111110
				S111111: err <= in ? 1 : 0; // error if we see 01111111...
				default: begin
					disc <= 0;
					flag <= 0;
					err <= 0;
				end
			endcase
		end
	end

	// Combinational next state logic
	always @(*) begin
		case (current_state)
			S0: next_state = in ? S1 : S0;
			S1: next_state = in ? S11 : S0;
			S11: next_state = in ? S111 : S0;
			S111: next_state = in ? S1111 : S0;
			S1111: next_state = in ? S11111 : S0;
			S11111: next_state = in ? S111111 : (in ? S111110 : S11111);
			S111110: next_state = in ? S1 : S0;
			S111111: next_state = S111111; // Remains in error state once reached
			default: next_state = S0;
		endcase
	end

endmodule
