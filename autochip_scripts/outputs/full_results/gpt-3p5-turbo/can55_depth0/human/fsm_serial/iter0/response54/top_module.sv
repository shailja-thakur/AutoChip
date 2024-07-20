module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define states
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA_BITS,
		STOP_BIT
	} state_t;

	// Define signals
	logic [7:0] data_bits;
	state_t state, next_state;

	// Flip-Flops
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			data_bits <= 8'b0;
		end
		else begin
			state <= next_state;
			data_bits <= {data_bits[6:0], in};
		end
	end

	// Next-state Logic
	always_comb begin
		next_state = state;
		case(state)
			IDLE: begin
				if (in == 1'b0)
					next_state = START_BIT;
			end
			START_BIT: begin
				next_state = DATA_BITS;
			end
			DATA_BITS: begin
				if (data_bits == 8'b11111111)
					next_state = STOP_BIT;
				else
					next_state = DATA_BITS;
			end
			STOP_BIT: begin
				if (in == 1'b1)
					next_state = IDLE;
			end
		endcase
	end

	// Output
	assign done = (state == STOP_BIT);

endmodule
