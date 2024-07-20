module stimulus_gen(
	output reg in,
	input reg clk,
	input reg reset);

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	reg [1:0] state;
	reg [7:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case(state)
				IDLE: begin
					counter <= 8'b0;
					state <= WAIT;
				end
				WAIT: begin
					counter <= counter + 1;
					if (counter >= 8'h0F)
						state <= PROCESS;
				end
				PROCESS: begin
					state <= DONE;
				end
				DONE: begin
					state <= IDLE;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case(state)
			IDLE: begin
				in <= 8'b0;
			end
			WAIT: begin
				in <= 8'b0;
			end
			PROCESS: begin
				in <= 8'b1;
			end
			DONE: begin
				in <= 8'b0;
			end
		endcase
	end

endmodule
module top_module(
	input clk,
	input reset,
	output reg [7:0] data_out,
	output reg valid_out);

	reg [1:0] state;
	reg [7:0] counter;

	parameter IDLE = 2'b00;
	parameter WAIT = 2'b01;
	parameter PROCESS = 2'b10;
	parameter DONE = 2'b11;

	stimulus_gen stimulus_gen (
		.in,
		.clk,
		.reset
	);

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= IDLE;
		else begin
			case(state)
				IDLE: begin
					counter <= 8'b0;
					data_out <= 8'b0;
					valid_out <= 0;
					state <= WAIT;
				end
				WAIT: begin
					counter <= counter + 1;
					data_out <= 8'b0;
					if (counter >= 8'h0F)
						state <= PROCESS;
				end
				PROCESS: begin
					data_out <= stimulus_gen.in;
					state <= DONE;
				end
				DONE: begin
					data_out <= stimulus_gen.in;
					valid_out <= 1;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
