module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		ONE,
		ZERO,
		DISCARD,
		FLAG,
		ERROR
	} state;

	// Declare state and output registers
	reg state current_state, next_state;
	reg disc_reg, flag_reg, err_reg;

	// Synchronous always block to control FSM transitions and outputs
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
			disc_reg <= 1'b0;
			flag_reg <= 1'b0;
			err_reg <= 1'b0;
		end else begin
			current_state <= next_state;
			disc_reg <= 1'b0;
			flag_reg <= 1'b0;
			err_reg <= 1'b0;
		end
	end
	
	// Combinational always block to determine next state and outputs based on current state and input
	always_comb begin
		case (current_state)
			IDLE:
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = ZERO;
				end
			ONE:
				if (in) begin
					next_state = DISCARD;
				end else begin
					next_state = ZERO;
				end
			ZERO:
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = IDLE;
				end
			DISCARD:
				if (in) begin
					next_state = ERROR;
				end else begin
					next_state = FLAG;
				end
			FLAG:
				if (in) begin
					next_state = ERROR;
				end else begin
					next_state = IDLE;
				end
			ERROR:
				next_state = ERROR; // Hold in error state until reset
		endcase
	end

	// Assign outputs based on current state
	assign disc = (current_state == DISCARD) ? 1'b1 : 1'b0;
	assign flag = (current_state == FLAG) ? 1'b1 : 1'b0;
	assign err = (current_state == ERROR) ? 1'b1 : 1'b0;

endmodule
