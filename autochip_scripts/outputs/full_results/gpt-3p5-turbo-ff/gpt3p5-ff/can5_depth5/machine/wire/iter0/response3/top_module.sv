module top_module(
	input clk,
	input reset,
	output reg data_out,
	output reg valid_out);

	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;
	
	// State definitions
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;
	
	// Always block
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
		end else begin
			case (state)
				IDLE: begin
					data_out <= 0;
					if (counter == 0) begin
						counter <= counter + 1;
					end
					if (counter == threshold_value) begin
						state <= WAIT;
						counter <= 0;
					end
				end
				WAIT: begin
					data_out <= 0;
					if (counter == threshold_value) begin
						state <= PROCESS;
						data_out <= data;
					end else begin
						counter <= counter + 1;
					end
				end
				PROCESS: begin
					data_out <= data;
					state <= DONE;
					valid_out <= 1;
				end
				DONE: begin
					valid_out <= 1;
					state <= IDLE;
					data_out <= 0;
				end
				default: state <= IDLE;
			endcase
		end
	end
	
endmodule
