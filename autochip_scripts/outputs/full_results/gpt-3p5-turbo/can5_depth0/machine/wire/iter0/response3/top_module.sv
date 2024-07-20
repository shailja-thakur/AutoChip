module top_module(
	input clk,
	input rst,
	output reg data_out,
	output reg valid_out);

	// internal signals
	reg [1:0] state;
	reg [7:0] counter;

	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	// default values
	assign data_out = 8'b00000000;
	assign valid_out = 1'b0;

	// FSM logic
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			state <= IDLE;
			counter <= 8'b00000000;
		end else begin
			case (state)
				IDLE: begin
					counter <= 8'b00000000;
					data_out <= 8'b00000000;
					if (rst) begin
						state <= IDLE;
					end else begin
						state <= WAIT;
					end
				end

				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'b00000000;
					
					if (counter == 8'b10101010) begin
						state <= PROCESS;
					end else begin
						state <= WAIT;
					end
				end

				PROCESS: begin
					data_out <= in;
					state <= DONE;
				end

				DONE: begin
					valid_out <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
