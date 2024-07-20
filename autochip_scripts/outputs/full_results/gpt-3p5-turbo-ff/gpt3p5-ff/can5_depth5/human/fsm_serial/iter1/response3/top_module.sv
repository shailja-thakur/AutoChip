module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	// Define state enumeration
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA,
		PARITY_BIT,
		STOP_BIT
	} state_t;
	
	// Define signals
	reg [2:0] state;
	reg [7:0] data;
	
	// Define signals for next state
	reg [2:0] next_state;
	reg [7:0] next_data;

	// Define signal for current bit position
	reg [2:0] bit_counter;

	// Define next state logic
	always_comb
	begin
		case (state)
			IDLE:
			begin
				if (in == 0)
					next_state = START_BIT;
				else
					next_state = IDLE;
			end

			START_BIT:
			begin
				next_state = DATA;
				next_data = 1;
				bit_counter = 0;
			end

			DATA:
			begin
				if (bit_counter == 7)
					next_state = PARITY_BIT;
				else
				begin
					next_state = DATA;
					next_data = {next_data[6:0], in};
					bit_counter = bit_counter + 1;
				end
			end

			PARITY_BIT:
			begin
				next_state = STOP_BIT;
			end

			STOP_BIT:
			begin
				if (in == 1)
					next_state = IDLE;
				else
					next_state = START_BIT;
			end
		endcase
	end

	// Define sequential logic
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			data <= 0;
		end
		else
		begin
			state <= next_state;
			data <= next_data;
		end
	end
	
	// Define output logic
	assign done = (state == STOP_BIT);

endmodule
