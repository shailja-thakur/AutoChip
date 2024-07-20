module top_module(
	input clk,
	input reset,
	output reg data_out,
	output reg valid_out);  	// Declare internal signals
	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data;  	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;  	// Initial state and assignments
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'b0;
			data_out <= 8'b0;
			valid_out <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					counter <= 8'b0;
					data_out <= 8'b0;
					if(counter >= 8'b100) begin
						state <= WAIT;
					end
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'b0;
					if(counter >= 8'b110) begin
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data_out <= data;
					state <= DONE;
				end
				DONE: begin
					valid_out <= 1'b1;
					state <= IDLE;
				end
			endcase
		end
	end endmodule
