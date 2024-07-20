module top_module(
	input wire clk,
	input wire reset,
	output reg [7:0] data,
	output reg valid);

	reg [2:0] state;
	reg [3:0] counter;

	parameter IDLE = 0;
	parameter WAIT = 1;
	parameter PROCESS = 2;
	parameter DONE = 3;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE: begin
					counter <= 0;
					data <= 8'b0;
					state <= WAIT;
				end
				WAIT: begin
					counter <= counter + 1;
					data <= 8'b0;
					if (counter == 10) // Replace 10 with your desired threshold
						state <= PROCESS;
				end
				PROCESS: begin
					data <= in;
					state <= DONE;
				end
				DONE: begin
					data <= in;
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
