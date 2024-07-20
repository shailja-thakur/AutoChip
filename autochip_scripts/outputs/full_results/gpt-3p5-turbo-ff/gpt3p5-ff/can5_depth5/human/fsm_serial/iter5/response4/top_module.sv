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
		STOP_BIT
	} state_t;
	
	// Define signals
	reg [2:0] state;
	reg [7:0] data;

	// Define signal for current bit position
	reg [2:0] bit_counter;
	reg start_bit_detected;

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
					if (bit_counter == 7)
						state <= STOP_BIT;
					else if (start_bit_detected)
					begin
						data[bit_counter] <= in;
						bit_counter <= bit_counter + 1;
					end
				STOP_BIT:
					if (start_bit_detected)
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
	assign done = (state == STOP_BIT);

	// Detect start bit
	always @(posedge clk)
	begin
		if (reset)
			start_bit_detected <= 0;
		else if (state == IDLE && in == 0)
			start_bit_detected <= 1;
		else if (state == STOP_BIT && in == 1)
			start_bit_detected <= 0;
	end

endmodule
