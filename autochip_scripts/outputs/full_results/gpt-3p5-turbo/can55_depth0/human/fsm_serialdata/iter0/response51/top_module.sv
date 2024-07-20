module top_module (
	input clk,
	input in,
	input reset,
	output [7:0] out_byte,
	output done
);

	// State definition
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;
	
	// Signal declaration
	state_t state, next_state;
	logic [7:0] shift_register;
	logic start_detected;
	logic [2:0] bit_count;
	
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			shift_register <= 8'b0;
			start_detected <= 1'b0;
			bit_count <= 0;
			out_byte <= 8'b0;
			done <= 1'b0;
		end
		else begin
			state <= next_state;
			shift_register <= {shift_register[6:0], in};  // Shift in the new bit
			
			case (state)
				IDLE:
					begin
						if (in == 1'b0)
							next_state = START_BIT;
						else
							next_state = IDLE;
							
						start_detected = 1'b0;
						bit_count = 0;
					end

				START_BIT:
					begin
						if (in == 1'b0)
							next_state = START_BIT;
						else
						begin
							next_state = DATA_BITS;
							start_detected = 1'b1;
							bit_count = 0;
						end
					end

				DATA_BITS:
					begin
						if (bit_count == 8)
							next_state = STOP_BIT;
						else
						begin
							next_state = DATA_BITS;
							start_detected = 1'b1;
							bit_count = bit_count + 1;
						end
					end

				STOP_BIT:
					begin
						if (bit_count == 0 && in == 1'b1 && start_detected == 1'b1)
						begin
							next_state = IDLE;
							start_detected = 1'b0;
							bit_count = 0;
							out_byte = shift_register[7:0];
							done = 1'b1;
						end
						else
						begin
							next_state = STOP_BIT;
							start_detected = 1'b1;
							bit_count = 0;
							out_byte = 8'b0;
							done = 1'b0;
						end
					end
					
				default: next_state = IDLE;
			endcase
		end
	end
endmodule
