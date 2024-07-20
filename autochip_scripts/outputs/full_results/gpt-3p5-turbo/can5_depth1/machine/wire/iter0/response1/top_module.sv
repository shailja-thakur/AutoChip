module top_module(
	input clock,
	input reset,
	output reg data_output,
	output reg valid_output);

	reg [1:0] state;
	reg [7:0] counter;
	
	// FSM states
	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;
	
	// initial state assignment
	always @(posedge clock) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
			data_output <= 0;
			valid_output <= 0;
		end
		else begin
			case(state)
				IDLE: begin
					counter <= 0;
					data_output <= 0;
					valid_output <= 0;
					if (in) begin
						state <= WAIT;
					end
				end
				
				WAIT: begin
					counter <= counter + 1;
					data_output <= 0;
					valid_output <= 0;
					if (counter >= 8) begin
						state <= PROCESS;
						counter <= 0;
					end
				end
				
				PROCESS: begin
					data_output <= in;
					valid_output <= 1;
					state <= DONE;
				end
				
				DONE: begin
					valid_output <= 1;
					state <= IDLE;
				end
			endcase
		end
	end	
endmodule
