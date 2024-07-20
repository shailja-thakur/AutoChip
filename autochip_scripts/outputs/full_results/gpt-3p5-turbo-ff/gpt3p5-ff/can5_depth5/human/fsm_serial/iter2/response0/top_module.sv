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
		STOP_BIT,
		STOP_BIT_WAIT
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
				begin
					if (in == 0)
						state <= START_BIT;
					else
						state <= IDLE;
				end

				START_BIT:
				begin
					state <= DATA;
					bit_counter <= 0;
					data <= 0;
				end

				DATA:
				begin
					if (bit_counter == 7)
						state <= STOP_BIT_WAIT;
					else
						bit_counter <= bit_counter + 1;
				end

				STOP_BIT_WAIT:
				begin
					if (in == 1)
						state <= STOP_BIT;
					else
						state <= STOP_BIT_WAIT;
				end

				STOP_BIT:
				begin
					if (in == 1)
						state <= IDLE;
					else
						state <= STOP_BIT_WAIT;
				end
			endcase
		end
	end
	
	// Define output logic
	assign done = (state == STOP_BIT);

endmodule
