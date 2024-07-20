module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// Define the states
	typedef enum logic [2:0] {
		S_IDLE,
		S_WAIT_DISCARD,
		S_WAIT_FLAG,
		S_WAIT_ERROR
	} state_t;
	reg state_t curr_state, next_state;
	
	// Combinational logic
	always_comb begin
		disc = 0;
		flag = 0;
		err = 0;
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
					disc = 0;
					flag = 0;
					err = 0;
				end else if (in) begin
					next_state = S_WAIT_DISCARD;
					disc = 0;
					flag = 0;
					err = 0;
				end else begin
					next_state = S_IDLE;
					disc = 0;
					flag = 0;
					err = 0;
				end
			
			S_WAIT_DISCARD:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc = 0;
					flag = 0;
					err = 0;
				end else if (in) begin
					next_state = S_WAIT_FLAG;
					disc = 1;
					flag = 0;
					err = 0;
				end
			
			S_WAIT_FLAG:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc = 0;
					flag = 0;
					err = 0;
				end else if (in) begin
					next_state = S_WAIT_FLAG;
					disc = 0;
					flag = 1;
					err = 0;
				end else if (!in) begin
					next_state = S_WAIT_ERROR;
					disc = 0;
					flag = 0;
					err = 0;
				end
			
			S_WAIT_ERROR:
				if (reset || !in) begin
					next_state = S_IDLE;
					disc = 0;
					flag = 0;
					err = 0;
				end else begin
					next_state = S_WAIT_ERROR;
					disc = 0;
					flag = 0;
					err = 1;
				end
		endcase
	end
endmodule
