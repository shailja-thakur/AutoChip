module top_module(
	input clock,
	input reset,
	output reg data_output,
	output reg valid_output);

	reg [1:0] state;
	reg [7:0] counter;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @ (posedge clock) begin
		if (reset) begin
			state <= IDLE;
			counter <= 8'd0;
			data_output <= 1'b0;
			valid_output <= 1'b0;
		end else begin
			case(state)
				IDLE: begin
					counter <= 8'd0;
					data_output <= 1'b0;
					valid_output <= 1'b0;
					if (in) begin
						state <= WAIT;
					end
				end
				WAIT: begin
					counter <= counter + 1;
					data_output <= 1'b0;
					
					if (counter == 8'd10) begin
						state <= PROCESS;
					end
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
endmodule
