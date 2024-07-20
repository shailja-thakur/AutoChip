module top_module(
	input wire clk,
	input wire rst,
	output reg out_data,
	output reg valid);

	reg [1:0] state;
	reg [3:0] counter;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 0;
			out_data <= 0;
		end else begin
			case (state)
				IDLE: begin
					state <= WAIT;
					counter <= 0;
					out_data <= 0;
				end

				WAIT: begin
					counter <= counter + 1;
					out_data <= 0;
					if (counter == 4'd10) begin
						state <= PROCESS;
						counter <= 0;
					end
				end

				PROCESS: begin
					out_data <= in;
					state <= DONE;
				end

				DONE: begin
					valid <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
