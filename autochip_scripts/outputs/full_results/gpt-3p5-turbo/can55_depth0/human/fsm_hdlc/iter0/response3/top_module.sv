module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define the states of the FSM
	typedef enum logic [2:0] {
		IDLE,
		ZERO,
		ONE,
		FIVE,
		FLAG,
		ERR
	} state_type;

	// Declare the state and next state variables
	reg state_type current_state, next_state;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			current_state <= IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	always_comb begin
		case (current_state)
			IDLE: begin
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = IDLE;
				end
			end
			ZERO: begin
				if (in) begin
					next_state = ONE;
				end else begin
					next_state = IDLE;
				end
			end
			ONE: begin
				if (in) begin
					next_state = FIVE;
				end else begin
					next_state = ZERO;
				end
			end
			FIVE: begin
				if (in) begin
					next_state = FLAG;
				end else begin
					next_state = ZERO;
				end
			end
			FLAG: begin
				if (in) begin
					next_state = ERR;
				end else begin
					next_state = IDLE;
				end
			end
			ERR: begin
				if (in) begin
					next_state = ERR;
				end else begin
					next_state = IDLE;
				end
			end
			default: next_state = IDLE;
		endcase
	end

	assign disc = (current_state == FIVE);
	assign flag = (current_state == FLAG);
	assign err = (current_state == ERR);

endmodule
