module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	// Define states for the finite state machine
	typedef enum logic [1:0] {
		IDLE,
		S1,
		S2,
		S3,
		S4
	} state_t;

	// Declare state and next_state variables
	state_t state;
	state_t next_state;

	// Declare register for storing whether the sequence has been found
	reg sequence_found;

	// Verilog always block for synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			sequence_found <= 0;
			start_shifting <= 0;
		end else begin
			state <= next_state;
			if (state == S4)
				sequence_found <= 1;
			else
				sequence_found <= 0;
			if (reset)
				start_shifting <= 0;
			else
				start_shifting <= sequence_found;
		end
	end

	// Verilog always_comb block for state transition and output logic
	always_comb begin
		case (state)
			IDLE: begin
				next_state = (data == 1'b1) ? S1 : IDLE;
			end
			S1: begin
				next_state = (data == 1'b1) ? S1 : S2;
			end
			S2: begin
				next_state = (data == 1'b0) ? S2 : S3;
			end
			S3: begin
				next_state = (data == 1'b1) ? S4 : S2;
			end
			S4: begin
				next_state = (data == 1'b1) ? S1 : S2;
			end
		endcase
	end

endmodule
