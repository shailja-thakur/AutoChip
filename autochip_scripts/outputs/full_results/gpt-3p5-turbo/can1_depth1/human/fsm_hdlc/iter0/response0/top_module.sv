module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// Define the states
	typedef enum logic [2:0] {
		S_IDLE,
		S_WAIT_DISCARD,
		S_WAIT_FLAG,
		S_WAIT_ERROR
	} state_t;
	reg state_t curr_state, next_state;
	
	// Define the outputs
	reg disc_out, flag_out, err_out;
	
	// Combinational logic
	always_comb begin
		disc = disc_out;
		flag = flag_out;
		err = err_out;
	end
	
	// Sequential logic
	always_ff @(posedge clk) begin
		if (reset) begin
			curr_state <= S_IDLE;
		end else begin
			curr_state <= next_state;
		end
	end
	
	// State transition and output logic
	always_comb begin
		case (curr_state)
			S_IDLE:
				if (reset) begin
					next_state = S_IDLE;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else if (in) begin
					next_state = S_WAIT_DISCARD;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = S_IDLE;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			
			S_WAIT_DISCARD:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else if (in) begin
					next_state = S_WAIT_FLAG;
					disc_out = 1;
					flag_out = 0;
					err_out = 0;
				end
			
			S_WAIT_FLAG:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else if (in) begin
					next_state = S_WAIT_FLAG;
					disc_out = 0;
					flag_out = 1;
					err_out = 0;
				end else if (!in) begin
					next_state = S_WAIT_ERROR;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end
			
			S_WAIT_ERROR:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc_out = 0;
					flag_out = 0;
					err_out = 0;
				end else begin
					next_state = S_WAIT_ERROR;
					disc_out = 0;
					flag_out = 0;
					err_out = 1;
				end
		endcase
	end

endmodule
