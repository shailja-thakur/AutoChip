module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

	// States
	typedef enum reg [2:0] {
		IDLE       = 3'b000,
		START_BIT  = 3'b001,
		DATA_BITS  = 3'b010,
		STOP_BIT   = 3'b011,
		WAIT_STOP  = 3'b100
	} state_t;
	
	state_t state, next_state;
	reg [2:0] bit_count;

	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			done <= 0;
			bit_count <= 0;
		end else begin
			state <= next_state;
			if (state == DATA_BITS) begin
				bit_count <= bit_count + 1;
			end else begin
				bit_count <= 0;
			end
		end
	end
	
	always_comb begin
		next_state = state;
		done = 0;
		
		case (state)
			IDLE: begin
				if (in == 0)
					next_state = START_BIT;
			end

			START_BIT: begin
				next_state = DATA_BITS;
			end

			DATA_BITS: begin
				if (bit_count == 3'd7) // If we've received 8 data bits
					next_state = STOP_BIT;
			end

			STOP_BIT: begin
				if (in == 1) begin
					done = 1;
					next_state = IDLE;
				end else begin
					next_state = WAIT_STOP;
				end
			end

			WAIT_STOP: begin
				if (in == 1)
					next_state = IDLE;
			end
			
			default: begin
				next_state = IDLE;
			end
		endcase
	end

endmodule
