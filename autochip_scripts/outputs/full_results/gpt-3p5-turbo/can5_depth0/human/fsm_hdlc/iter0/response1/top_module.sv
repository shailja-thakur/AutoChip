module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	// Define the states
	typedef enum logic [2:0] {
		IDLE,
		FOUND_0,
		FOUND_01,
		FOUND_011,
		FOUND_0111,
		FOUND_FLAG,
		ERROR
	} state_t;
	
	// Define the signal durations
	parameter DURATION_0 = 1;
	parameter DURATION_1 = 6;
	
	// Define the state and output registers
	reg state_t current_state, next_state;
	reg disc_reg, flag_reg, err_reg;
	
	// Initialize the registers and outputs
	initial begin
		current_state = IDLE;
		disc_reg = 0;
		flag_reg = 0;
		err_reg = 0;
	end
	
	// Sequential logic to update the state and output registers
	always @(posedge clk) begin
		if (reset) begin
			current_state <= IDLE;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
		end else begin
			current_state <= next_state;
			disc_reg <= 0;
			flag_reg <= 0;
			err_reg <= 0;
		end
	end
	
	// Combinational logic to determine the next state and outputs
	always @(*) begin
		case (current_state)
			IDLE: begin
				next_state = in ? FOUND_0 : IDLE;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			FOUND_0: begin
				next_state = in ? FOUND_01 : IDLE;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			FOUND_01: begin
				next_state = in ? FOUND_011 : IDLE;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			FOUND_011: begin
				next_state = in ? FOUND_0111 : IDLE;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			FOUND_0111: begin
				next_state = in ? ERROR : FOUND_FLAG;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 0;
			end
			FOUND_FLAG: begin
				next_state = in ? ERROR : FOUND_FLAG;
				disc_reg = 0;
				flag_reg = 1;
				err_reg = 0;
			end
			ERROR: begin
				next_state = in ? ERROR : FOUND_0;
				disc_reg = 0;
				flag_reg = 0;
				err_reg = 1;
			end
		endcase
	end
	
	// Assign the outputs
	assign disc = disc_reg;
	assign flag = flag_reg;
	assign err = err_reg;

endmodule
