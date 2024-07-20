module top_module(
	input wire clk,
	input wire reset,
	output reg [7:0] data_output,
	output reg valid_output);

	// internal signals
	reg [1:0] state;
	reg [7:0] counter;

	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case (state)
				IDLE: begin
					data_output <= 8'b0;
					counter <= 8'b0;
					if (reset)
						state <= IDLE;
					else
						state <= WAIT;
				end

				WAIT: begin
					counter <= counter + 1;
					data_output <= 8'b0;
					if (counter == 8'hFF) // Modify the threshold value as needed
						state <= PROCESS;
					else
						state <= WAIT;
				end

				PROCESS: begin
					data_output <= in;
					state <= DONE;
				end

				DONE: begin
					valid_output <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end

	assign out = data_output;

endmodule
