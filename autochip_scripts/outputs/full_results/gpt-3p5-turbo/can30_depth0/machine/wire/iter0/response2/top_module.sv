module top_module(
	input wire clk,
	input wire rst,
	output reg [7:0] data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [3:0] counter;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge rst)
	begin
		if(rst)
		begin
			state <= IDLE;
			counter <= 0;
			data_out <= 8'b0;
			valid_out <= 0;
		end
		else
		begin
			case(state)
				IDLE: begin
					counter <= 0;
					data_out <= 8'b0;
					valid_out <= 0;
					if(in)
						state <= WAIT;
				end

				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'b0;
					valid_out <= 0;
					if(counter == 4)
						state <= PROCESS;
				end

				PROCESS: begin
					data_out <= in;
					valid_out <= 1;
					state <= DONE;
				end

				DONE: begin
					valid_out <= 0;
					state <= IDLE;
				end
			endcase
		end
	end
	
endmodule
