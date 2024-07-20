module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define the states
	typedef enum logic [2:0] {
		START,
		FIND_1,
		FIND_11,
		FIND_110,
		FIND_1101,
		FOUND
	} state_t;

	// Define the state register and next state logic
	reg state_t curr_state, next_state;

	// Define the start_shifting output and internal signal
	reg start_shifting;
	wire start_shift_internal;

	// Define the state transition logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			curr_state <= START;
		end else begin
			curr_state <= next_state;
		end
	end

	// Define the state and output logic
	always_comb begin
		case (curr_state)
			START: begin
				if (data == 1'b1) begin
					next_state = FIND_1;
				end else begin
					next_state = START;
				end
			end
			FIND_1: begin
				if (data == 1'b1) begin
					next_state = FIND_11;
				end else begin
					next_state = START;
				end
			end
			FIND_11: begin
				if (data == 1'b0) begin
					next_state = START;
				end else begin
					next_state = FIND_110;
				end
			end
			FIND_110: begin
				if (data == 1'b1) begin
					next_state = FIND_1101;
				end else begin
					next_state = START;
				end
			end
			FIND_1101: begin
				if (data == 1'b1) begin
					next_state = FIND_1101;
				end else begin
					next_state = FOUND;
				end
			end
			FOUND: begin
				next_state = FOUND;
			end
			default: begin
				next_state = START;
			end
		endcase
	end

	// Define the start_shifting output logic
	always_comb begin
		start_shift_internal = (curr_state == FOUND) ? 1 : 0;
	end

	// Synchronize the start_shifting signal with the clock
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			start_shifting <= 0;
		end else begin
			start_shifting <= start_shift_internal;
		end
	end
endmodule
