module top_module (
	input clk,
	input reset,
	input [3:1] s,
	output reg fr3,
	output reg fr2,
	output reg fr1,
	output reg dfr
);
	
	// State encoding
	typedef enum logic [1:0] {
		LOW = 2'b00,
		MID = 2'b01,
		HIGH = 2'b10,
		FULL = 2'b11
	} state_t;

	state_t current_state, next_state;
	logic prev_flow_increase;

	// State Machine
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= LOW;
			prev_flow_increase <= 0;
		end else begin
			current_state <= next_state;
			prev_flow_increase <= (next_state > current_state) ? 1 : 0;
		end
	end

	// Next State Logic
	always_comb begin
		case (s)
			3'b111: next_state = FULL;
			3'b011: next_state = HIGH;
			3'b001: next_state = MID;
			default: next_state = LOW;
		endcase
	end

	// Output Logic
	always_comb begin
		// Default outputs
		fr3 = 0;
		fr2 = 0;
		fr1 = 0;
		dfr = 0;

		case (current_state)
			LOW: begin
				fr3 = 1;
				fr2 = 1;
				fr1 = 1;
			end
			MID: begin
				fr2 = 1;
				fr1 = 1;
				dfr = prev_flow_increase;
			end
			HIGH: begin
				fr1 = 1;
				dfr = prev_flow_increase;
			end
			FULL: begin
				// No flow
			end
		endcase
	end
endmodule
