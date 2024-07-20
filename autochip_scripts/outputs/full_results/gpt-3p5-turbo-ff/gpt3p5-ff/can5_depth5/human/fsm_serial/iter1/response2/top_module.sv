module top_module (
	input clk,
	input reset,
	input in,
	output reg done
);

	// Define state enumeration
	typedef enum logic [2:0] {
		IDLE,
		START_BIT,
		DATA,
		STOP_BIT
	} state_t;
	
	// Define signals and variables
	reg [2:0] state;
	reg [7:0] data;
	reg [2:0] bit_counter;
	reg expected_stop_bit;

	// Define next state and output logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			bit_counter <= 0;
			done <= 0;
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
					state <= DATA;
					bit_counter <= 0;
					data <= 0;
					expected_stop_bit <= 0;
				end

				DATA:
				begin
					if (bit_counter == 7)
						state <= STOP_BIT;
					else
					begin
						if (in)
							data[bit_counter] = 1;
						else
							data[bit_counter] = 0;
						bit_counter <= bit_counter + 1;
					end
				end

				STOP_BIT:
				begin
					if (in == 1)
						state <= IDLE;
					else
						state <= START_BIT;
					expected_stop_bit <= 1;
				end
			endcase
		end
	end
	
	// Output logic
	always @(posedge clk)
	begin
		if (state == STOP_BIT && in == expected_stop_bit)
			done <= 1;
	end

endmodule
