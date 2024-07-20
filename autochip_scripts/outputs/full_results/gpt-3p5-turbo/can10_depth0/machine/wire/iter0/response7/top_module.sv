module top_module(
	input clk,
	input reset,
	output reg data_out,
	output reg valid_out);
	
	// Internal signals
	reg [1:0] state;
	reg [7:0] counter;
	
	// State constants
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;
	
	// Initial state assignment
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else
			state <= state;
	end
	
	// State transition and output logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
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
					
					if (counter == 10) begin
						state <= PROCESS;
					end
				end
				
				PROCESS: begin
					data_out <= in;
					valid_out <= 1;
					state <= DONE;
				end
				
				DONE: begin
					data_out <= in;
					valid_out <= 1;
					state <= IDLE;
				end
			endcase
		end
	end
endmodule
