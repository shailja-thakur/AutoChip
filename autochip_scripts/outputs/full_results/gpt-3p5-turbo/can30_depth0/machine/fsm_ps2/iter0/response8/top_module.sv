module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	// Define state enumeration
	typedef enum logic [1:0] {
		BYTE1,
		BYTE2,
		BYTE3,
		DONE
	} state;

	// Declare state and next_state signals
	reg state current_state;
	reg state next_state;

	// State logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= BYTE1;
		else
			current_state <= next_state;
	end

	// Next state logic
	always @(current_state or in) begin
		case (current_state)
			BYTE1: begin
				if (in[2])
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			BYTE2: next_state = BYTE3;
			BYTE3: next_state = DONE;
			DONE: begin
				if (in[2])
					next_state = BYTE2;
				else
					next_state = BYTE1;
			end
			default: next_state = BYTE1;
		endcase
	end

	// Output logic
	always @(current_state) begin
		if (current_state == DONE)
			done = 1;
		else
			done = 0;
	end
endmodule
