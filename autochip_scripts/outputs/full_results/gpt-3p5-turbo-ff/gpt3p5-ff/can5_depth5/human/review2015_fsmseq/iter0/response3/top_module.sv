module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);
	
	// Define states for the finite-state machine
	enum {IDLE, S0, S1, S2, S3, DONE} state;
	
	// Registers to store the current and previous input bits
	reg [1:0] previous_input;
	reg [1:0] current_input;
	
	// Initialize the registers and state
	initial begin
		previous_input = 2'b00;
		current_input = 2'b00;
		state = IDLE;
	end
	
	// Synchronous reset
	always @(posedge clk) begin
		if (reset) begin
			state <= IDLE;
			previous_input <= 2'b00;
			current_input <= 2'b00;
			start_shifting <= 0;
		end else begin
			previous_input <= current_input;
			current_input <= data;
			
			// State transition
			case (state)
				IDLE: if (current_input == 2'b1) begin
							state <= S0;
						end
				S0: if (current_input == 2'b1) begin
						state <= S1;
					end else begin
						state <= IDLE;
					end
				S1: if (current_input == 2'b0) begin
						state <= S2;
					end else begin
						state <= IDLE;
					end
				S2: if (current_input == 2'b1) begin
						state <= S3;
					end else begin
						state <= IDLE;
					end
				S3: if (current_input == 2'b0) begin
						state <= DONE;
					end else begin
						state <= IDLE;
					end
				DONE: state <= IDLE;
			endcase
			
			// Output logic
			if (state == DONE) begin
				start_shifting <= 1;
			end else begin
				start_shifting <= 0;
			end
		end
	end
endmodule
