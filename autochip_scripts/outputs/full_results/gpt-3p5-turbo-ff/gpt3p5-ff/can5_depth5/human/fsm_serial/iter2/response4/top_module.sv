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
		STOP_BIT_1,
		STOP_BIT_2
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
						state <= STOP_BIT_1;
					else
						bit_counter <= bit_counter + 1;
				end

				STOP_BIT_1:
				begin
					state <= STOP_BIT_2;
				end

				STOP_BIT_2:
				begin
					if (in == 1)
						state <= IDLE;
					else
						state <= STOP_BIT_1;
				end
			endcase
		end
	end
	
	// Define output logic
	assign done = (state == STOP_BIT_2);

endmodule
