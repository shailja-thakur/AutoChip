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
	reg [2:0] bit_count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			bit_count <= 3'b000;
			done <= 1'b0;
		end else begin
			state <= next_state;
			if (state == DATA_BITS) begin
				bit_count <= bit_count + 1;
			end else if (state == STOP_BIT || state == START_BIT || state == ERROR) begin
				bit_count <= 3'b000;
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
				next_state = DATA_BITS;
			end
			
			DATA_BITS: begin
				if (bit_count == 3'b111) begin
					next_state = STOP_BIT;
				end else begin
					next_state = DATA_BITS;
				end
			end
			
			STOP_BIT: begin
				if (in == 1'b1) begin
					done = 1'b0; // Set done to 1 for only one clock cycle
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
