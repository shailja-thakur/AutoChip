module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// Define the states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA,
		STOP_BIT
	} state_t;
	
	// Define the signals
	logic [7:0] reg_data;
	state_t state;
	logic start_bit_det;
	logic stop_bit_det;
	reg wire done;
	
	// Synchronous reset
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	// Combinatorial logic
	always_comb begin
		start_bit_det = (state == IDLE && in == 0);
		stop_bit_det = (state == DATA && in == 1);
	end
	
	// Next state logic
	always_comb begin
		case (state)
			IDLE:
				if (start_bit_det)
					next_state = START_BIT;
			START_BIT:
				if (!start_bit_det)
					next_state = DATA;
				else if (stop_bit_det)
					next_state = STOP_BIT;
			DATA:
				if (stop_bit_det)
					next_state = STOP_BIT;
			STOP_BIT:
				next_state = IDLE;
		endcase
	end
	
	// Output logic
	always_ff @(posedge clk) begin
		case (state)
			IDLE:
				reg_data <= 8'b0;
			START_BIT:
				reg_data <= {reg_data[6:0], in};
			DATA:
				reg_data <= {reg_data[6:0], in};
			STOP_BIT:
				reg_data <= {reg_data[6:0], in};
		endcase
		
		if (state == STOP_BIT)
			done <= 1;
		else
			done <= 0;
		
		out_byte = reg_data;
	end
	
endmodule
