module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define the states of the finite-state machine
	enum {START, S1, S2, S3, FINISHED} state;

	// Create registers to store current and next state
	reg [3:0] current_state;
	reg [3:0] next_state;

	// Create a register to store the output
	reg start_shifting;

	// Sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= START;
			start_shifting <= 0;
		end else begin
			current_state <= next_state;
			start_shifting <= (current_state == FINISHED);
		end
	end

	// Combinational logic
	always @* begin
		case (current_state)
			START: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = START;
				end
			end

			S1: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = S2;
				end
			end

			S2: begin
				if (data) begin
					next_state = S1;
				end else begin
					next_state = S3;
				end
			end

			S3: begin
				if (data) begin
					next_state = FINISHED;
				end else begin
					next_state = START;
				end
			end

			FINISHED: begin
				next_state = FINISHED;
			end
		endcase
	end
endmodule
