module top_module(
	input wire clk,
	input wire rst,
	input wire in,
	output reg out,
	output reg valid);

	// internal signals
	reg [1:0] state;
	reg [7:0] counter;

	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// reset state and outputs
	always @(posedge clk, posedge rst)
	begin
		if (rst)
		begin
			state <= IDLE;
			counter <= 0;
			out <= 0;
			valid <= 0;
		end
		else
		begin
			case (state)
				IDLE:
				begin
					counter <= 0;
					out <= 0;
					valid <= 0;
					if (in)
						state <= WAIT;
				end

				WAIT:
				begin
					counter <= counter + 1;
					out <= 0;
					valid <= 0;
					if (counter == 8'hFF)
						state <= PROCESS;
				end

				PROCESS:
				begin
					out <= in;
					valid <= 1;
					state <= DONE;
				end

				DONE:
				begin
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
