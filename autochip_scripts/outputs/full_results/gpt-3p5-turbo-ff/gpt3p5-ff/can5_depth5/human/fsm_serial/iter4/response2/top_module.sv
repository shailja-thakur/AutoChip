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
		DATA1,
		DATA2,
		DATA_WAIT,
		STOP_BIT
	} state_t;
	
	// Define signals
	reg [2:0] state;
	reg [7:0] data;

	// Define signal for current bit position
	reg [2:0] bit_counter;

	// Define next state logic and data transition
	always_ff @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			data <= 8'b0;
			bit_counter <= 3'b0;
		end
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
					state <= DATA1;
					bit_counter <= 3'b0;
				end

				DATA1:
				begin
					bit_counter <= bit_counter + 1;
					data <= {in, data[7:1]};
					if (bit_counter == 7)
						state <= DATA2;
				end

				DATA2:
				begin
					bit_counter <= bit_counter + 1;
					data <= {in, data[7:1]};
					if (bit_counter == 7)
						state <= DATA_WAIT;
				end

				DATA_WAIT:
				begin
					if (in == 1)
						state <= STOP_BIT;
				end

				STOP_BIT:
				begin
					if (in == 1)
						state <= IDLE;
					else
						state <= START_BIT;
				end
			endcase
		end
	end
	
	// Define output logic
	assign done = (state == DATA_WAIT);

endmodule
