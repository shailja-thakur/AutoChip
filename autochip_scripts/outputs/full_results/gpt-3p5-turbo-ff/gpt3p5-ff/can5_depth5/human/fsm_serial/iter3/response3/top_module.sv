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
					data <= 0;
					bit_counter <= 0;
				end

				DATA:
				begin
					if (bit_counter == 7)
						state <= DATA_WAIT;
					else
						bit_counter <= bit_counter + 1;
				end

				DATA_WAIT:
				begin
					state <= STOP_BIT;
					bit_counter <= 0;
				end

				STOP_BIT:
				begin
					if (bit_counter == 1 && in == 1)
						state <= IDLE;
					else
					begin
						bit_counter <= bit_counter + 1;
						state <= START_BIT;
					end
				end
			endcase
		end
	end
	
	// Define output logic
	assign done = (state == DATA_WAIT);

endmodule
