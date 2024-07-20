module top_module(
	input clk,
	input rst,
	output reg data_out,
	output reg valid_out);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;

	// FSM states
	parameter [1:0] IDLE = 2'b00;
	parameter [1:0] WAIT = 2'b01;
	parameter [1:0] PROCESS = 2'b10;
	parameter [1:0] DONE = 2'b11;

	// Initialize signals
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 0;
			data_out <= 0;
			valid_out <= 0;
		end else begin
			case (state)
				IDLE: begin
					counter <= 0;
					data_out <= 0;
					valid_out <= 0;
					if (in) begin
						state <= WAIT;
					end
				end

				WAIT: begin
					counter <= counter + 1;
					data_out <= 0;
					valid_out <= 0;
					if (counter == 10) begin // Adjust threshold as needed
						state <= PROCESS;
					end
				end

				PROCESS: begin
					data_out <= in;
					valid_out <= 1;
					state <= DONE;
				end

				DONE: begin
					valid_out <= 1;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
