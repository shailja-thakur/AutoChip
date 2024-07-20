module top_module(
	input clock,
	input reset,
	output reg data_output,
	output reg valid_output
);
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;

	// States
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// State transitions
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'b0;
			data_output <= 8'b0;
			valid_output <= 1'b0;
		end else begin
			case (state)
				IDLE:
					if (reset)
						state <= IDLE;
					else
						state <= WAIT;
				WAIT:
					if (counter >= 8'hFF)
						state <= PROCESS;
					else
						state <= WAIT;
				PROCESS:
					state <= DONE;
				DONE:
					state <= IDLE;
			endcase
		end
	end

	// State actions
	always @(posedge clock) begin
		case (state)
			IDLE:
				counter <= 8'b0;
				data_output <= 8'b0;
				valid_output <= 1'b0;
			WAIT:
				counter <= counter + 1;
				data_output <= 8'b0;
				valid_output <= 1'b0;
			PROCESS:
				data_output <= data;
				valid_output <= 1'b1;
			DONE:
				counter <= 8'b0;
				data_output <= 8'b0;
				valid_output <= 1'b0;
		endcase
	end

	// Data processing logic
	always @(posedge clock) begin
		case (state)
			PROCESS:
				data <= in;
		endcase
	end
endmodule
