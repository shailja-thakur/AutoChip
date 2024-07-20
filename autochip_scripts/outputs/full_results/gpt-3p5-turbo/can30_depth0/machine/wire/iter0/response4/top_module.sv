module top_module(
	input wire clock,
	input wire reset,
	output reg data_output,
	output reg valid_output);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;

	// State definitions
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// Initial state assignment
	always @(posedge reset) begin
		if (reset)
			state <= IDLE;
	end

	// FSM logic
	always @(posedge clock) begin
		case(state)
			IDLE:
				begin
					counter <= 0;
					data_output <= 0;
					if (reset)
						state <= IDLE;
					else
						state <= WAIT;
				end

			WAIT:
				begin
					counter <= counter + 1;
					data_output <= 0;
					if (counter == 8'b11111111)
						state <= PROCESS;
					else
						state <= WAIT;
				end

			PROCESS:
				begin
					data_output <= in;
					state <= DONE;
				end

			DONE:
				begin
					valid_output <= 1;
					state <= IDLE;
				end
		endcase
	end
endmodule
