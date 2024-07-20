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
		DATA_WAIT,
		STOP_BIT
	} state_t;
	
	// Define signals
	reg [2:0] state;
	reg [7:0] data;

	// Define signal for current bit position
	reg [2:0] bit_counter;

	// Define next state logic
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
		begin
			case (state)
				IDLE:
				if (in == 0)
					state <= START_BIT;

				START_BIT:
				state <= DATA;

				DATA:
				begin
					if (bit_counter == 7)
						state <= DATA_WAIT;
					else if (bit_counter == 0)
					begin
						data[bit_counter] <= in;
						bit_counter <= bit_counter + 1;
					end
					else
					begin
						data[bit_counter] <= in;
						bit_counter <= bit_counter + 1;
					end
				end

				DATA_WAIT:
				state <= STOP_BIT;

				STOP_BIT:
				if (in == 1)
					state <= IDLE;
				else
					state <= START_BIT;
			endcase
		end
	end
	
	// Define output logic
	assign done = (state == DATA_WAIT);

endmodule
