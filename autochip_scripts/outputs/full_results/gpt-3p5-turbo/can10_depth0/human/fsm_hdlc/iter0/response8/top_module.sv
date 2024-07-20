module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define states
	typedef enum logic [2:0] {
		S_IDLE,
		S_P1,
		S_P2,
		S_P3,
		S_P4,
	} state_t;
	
	// Declare state and next_state variables
	state_t state, next_state;
	
	// Declare flag_seen, err_seen, and disc_seen variables
	logic flag_seen, err_seen, disc_seen;
	
	// Assign initial values to variables
	assign flag_seen = 0;
	assign err_seen = 0;
	assign disc_seen = 0;
	
	// Sequential logic process for state transition and output generation
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= S_IDLE;
		end else begin
			state <= next_state;
		end
	end
	
	// Combinational logic process for next_state generation and output generation
	always_comb begin
		case (state)
			S_IDLE: begin
				if (in) begin
					next_state = S_P1;
				end else begin
					next_state = S_IDLE;
				end
			end
			S_P1: begin
				if (in) begin
					next_state = S_P1;
				end else begin
					next_state = S_P2;
				end
			end
			S_P2: begin
				if (in) begin
					next_state = S_P3;
				end else begin
					next_state = S_P2;
				end
			end
			S_P3: begin
				if (in) begin
					next_state = S_P4;
				end else begin
					next_state = S_P2;
				end
			end
			S_P4: begin
				if (in) begin
					next_state = S_P3;
				end else begin
					next_state = S_P2;
				end
			end
			default: next_state = S_IDLE;
		endcase
		
		// Output generation
		case (state)
			S_IDLE: begin
				flag = 0;
				err = 0;
				disc = 0;
			end
			S_P1: begin
				if (in) begin
					flag = 0;
					err = 1;
					disc = 0;
				end else begin
					flag_seen = 0;
					err_seen = 0;
					disc_seen = 0;
					flag = 0;
					err = 0;
					disc = 0;
				end
			end
			S_P2: begin
				if (in) begin
					flag = 0;
					err = 1;
					disc = 0;
				end else begin
					flag_seen = 0;
					err_seen = 0;
					disc_seen = 0;
					flag = 0;
					err = 0;
					disc = 0;
				end
			end
			S_P3: begin
				if (in) begin
					flag = 0;
					err = 1;
					disc = 0;
				end else begin
					flag_seen = 0;
					err_seen = 0;
					disc_seen = 0;
					flag = 0;
					err = 0;
					disc = 0;
				end
			end
			S_P4: begin
				if (in) begin
					flag = 0;
					err = 0;
					disc = 1;
				end else begin
					flag_seen = 1;
					err_seen = 0;
					disc_seen = 0;
					flag = flag_seen;
					err = 0;
					disc = 0;
				end
			end
			default: begin
				flag = 0;
				err = 0;
				disc = 0;
			end
		endcase
	end
	
endmodule
