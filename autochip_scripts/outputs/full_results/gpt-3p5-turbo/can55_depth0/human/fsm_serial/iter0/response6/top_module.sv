module top_module (
	input clk,
	input in,
	input reset,
	output done
);
	
	// Define state enum
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;
	
	// Define state register and next state
	state_t state_reg, state_next;
	
	// Define data register
	reg [7:0] data;
	
	// Define start and stop bit flags
	reg start_bit_flag, stop_bit_flag;
	
	// Define done flag
	reg done_flag;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= IDLE;
			start_bit_flag <= 0;
			stop_bit_flag <= 0;
			data <= 0;
			done_flag <= 0;
		end else begin
			state_reg <= state_next;
			
			if (state_next == IDLE) begin
				start_bit_flag <= 0;
				stop_bit_flag <= 0;
			end else if (state_next == START_BIT) begin
				start_bit_flag <= 1;
				stop_bit_flag <= 0;
			end else if (state_next == STOP_BIT) begin
				start_bit_flag <= 0;
				stop_bit_flag <= 1;
			end else begin
				start_bit_flag <= 0;
				stop_bit_flag <= 0;
			end
			
			if (state_next == DATA_BITS) begin
				data <= {in, data[7:1]};
			end
			
			done_flag <= 0;
		end
	end
	
	always_comb begin
		case (state_reg)
			IDLE:
				if (in == 0)
					state_next = START_BIT;
				else
					state_next = IDLE;
			
			START_BIT:
				if (in == 0)
					state_next = DATA_BITS;
				else
					state_next = START_BIT;
			
			DATA_BITS:
				if (in == 0)
					state_next = DATA_BITS;
				else
					state_next = STOP_BIT;
			
			STOP_BIT:
				if (in == 1)
					state_next = IDLE;
				else
					state_next = STOP_BIT;
		endcase
	end
	
	always_ff @(posedge clk) begin
		if (state_reg == STOP_BIT && stop_bit_flag) begin
			done_flag <= 1;
		end
	end
	
	assign done = done_flag;
	
endmodule
