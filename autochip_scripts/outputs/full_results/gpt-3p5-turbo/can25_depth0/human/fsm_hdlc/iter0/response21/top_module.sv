module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [1:0] {
		IDLE,
		S1,
		S2,
		S3
	} state_t;
	
	// Define internal signals
	logic [1:0] state;
	logic [5:0] count;
	logic prev_input;
	
	// Output assignment
	assign disc = (state == S1);
	assign flag = (state == S2);
	assign err = (state == S3);
	
	// Synchronous reset
	always_ff @(posedge clk, posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// State logic
	always_comb begin
		case (state)
			IDLE: begin
				count = 0;
				
				if (in)
					state = S1;
			end
			S1: begin
				count = count + 1;
				
				if (count == 5 && in)
					state = S2;
				else if (count >= 7)
					state = S3;
				else if (!in)
					state = IDLE;
			end
			S2: begin
				if (!in)
					state = S3;
				else if (prev_input)
					state = IDLE;
			end
			S3: begin
				if (!in)
					state = S1;
				else if (!prev_input)
					state = IDLE;
			end
		endcase
	end
	
	// Store previous input
	always_ff @(posedge clk) begin
		prev_input <= in;
	end
	
endmodule
