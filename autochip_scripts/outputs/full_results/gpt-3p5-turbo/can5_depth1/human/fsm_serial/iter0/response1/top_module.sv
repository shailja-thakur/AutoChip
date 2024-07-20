module top_module (
	input clk,
	input in,
	input reset,
	output done
);

	reg [2:0] state;

	// Define states
	parameter IDLE = 3'b000;
	parameter START_BIT = 3'b001;
	parameter DATA_BITS = 3'b010;
	parameter STOP_BIT = 3'b011;
	parameter ERROR = 3'b100;
	parameter WAIT_STOP_BIT = 3'b101;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= IDLE;
		else
		begin
			case (state)
				IDLE: 
					if (in == 1'b0)
						state <= START_BIT;
				START_BIT:
					if (in == 1'b0)
						state <= DATA_BITS;
					else
						state <= ERROR; // Incorrect start bit
				DATA_BITS:
					if (in == 1'b0)
						state <= DATA_BITS;
					else
						state <= STOP_BIT;
				STOP_BIT:
					if (in == 1'b1)
						state <= IDLE;
					else
						state <= ERROR; // Incorrect stop bit
				ERROR:
					state <= IDLE;
				WAIT_STOP_BIT:
					if (in == 1'b1)
						state <= IDLE;
					else
						state <= WAIT_STOP_BIT;
			endcase
		end
	end

	assign done = (state == IDLE);

endmodule
