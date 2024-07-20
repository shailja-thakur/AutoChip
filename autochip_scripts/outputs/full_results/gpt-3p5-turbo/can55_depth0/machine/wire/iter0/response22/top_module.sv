module top_module(
	input wire clk,
	input wire rst,
	output reg [7:0] data_out,
	output reg valid_out);

	reg [7:0] state;
	reg [7:0] counter;

	parameter IDLE_STATE = 0;
	parameter WAIT_STATE = 1;
	parameter PROCESS_STATE = 2;
	parameter DONE_STATE = 3;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE_STATE;
			counter <= 0;
			data_out <= 0;
			valid_out <= 0;
		end else begin
			case(state)
				IDLE_STATE: begin
					counter <= 0;
					data_out <= 0;

					if (in == 1'b1) begin
						state <= WAIT_STATE;
					end
				end

				WAIT_STATE: begin
					counter <= counter + 1;
					data_out <= 0;

					if (counter == 4'b1000) begin
						state <= PROCESS_STATE;
					end
				end

				PROCESS_STATE: begin
					data_out <= in;
					state <= DONE_STATE;
				end

				DONE_STATE: begin
					valid_out <= 1;
					state <= IDLE_STATE;
				end
			endcase
		end
	end

endmodule
