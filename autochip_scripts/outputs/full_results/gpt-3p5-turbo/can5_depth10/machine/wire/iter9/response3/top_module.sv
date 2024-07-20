module top_module(
	input clk,
	input reset,
	input in,
	output out);

	reg [1:0] state;
	reg [7:0] counter;
	reg [7:0] data_out;
	reg valid_out;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			counter <= 0;
			data_out <= 0;
			valid_out <= 0;
		end
		else begin
			case(state)
				IDLE: begin
					data_out <= 0;
					if (counter < 10)
						counter <= counter + 1;
					else begin
						counter <= 0;
						state <= WAIT;
					end
				end
				WAIT: begin
					data_out <= 0;
					if (counter < 10)
						counter <= counter + 1;
					else begin
						counter <= 0;
						state <= PROCESS;
					end
				end
				PROCESS: begin
					data_out <= in;
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

	assign out = data_out;

endmodule
