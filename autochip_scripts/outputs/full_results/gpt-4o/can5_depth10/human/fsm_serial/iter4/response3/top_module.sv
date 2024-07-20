module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// States of the FSM
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT,
		ERROR
	} state_t;
	
	state_t state, next_state;
	reg [3:0] bit_count; // Use 4 bits to count up to 9 (0-8 for data bits + stop bit)

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 4'b0000;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (state == DATA_BITS || state == START_BIT) begin
				bit_count <= bit_count + 1;
			end else if (state == STOP_BIT || state == ERROR) begin
				bit_count <= 4'b0000;
			end
		end
	end
	
	always @(*) begin
		next_state = state;
		done = 1'b0;
		case(state)
			IDLE: begin
				if (in == 1'b0) begin
					next_state = START_BIT;
				end
			end
			
			START_BIT: begin
				if (bit_count == 1) next_state = DATA_BITS;				
			end
			
			DATA_BITS: begin
				if (bit_count == 9) begin
					next_state = STOP_BIT;
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b1) begin
					done = 1'b1;
					next_state = IDLE;
				end else begin
					next_state = ERROR;
				end
			end
			
			ERROR: begin
				if (in == 1'b1) begin
					next_state = IDLE;
				end
			end
			
			default: next_state = IDLE;
		endcase
	end
endmodule
