module top_module(
	input wire clk,
	input wire reset,
	output reg out,
	output reg valid);

	reg [1:0] state;
	reg [7:0] counter;

	// state definitions
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
		begin
			state <= IDLE;
			counter <= 8'd0;
			out <= 1'b0;
			valid <= 1'b0;
		end
		else
		begin
			case (state)
				IDLE:
				begin
					counter <= 8'd0;
					out <= 1'b0;
					valid <= 1'b0;

					state <= WAIT;
				end

				WAIT:
				begin
					counter <= counter + 1;
					out <= 1'b0;
					valid <= 1'b0;

					if (counter == 8'hFF)
						state <= PROCESS;
				end

				PROCESS:
				begin
					out <= in;
					valid <= 1'b1;

					state <= DONE;
				end

				DONE:
				begin
					out <= 1'b0;
					valid <= 1'b1;

					state <= IDLE;
				end
			endcase
		end
	end
endmodule
