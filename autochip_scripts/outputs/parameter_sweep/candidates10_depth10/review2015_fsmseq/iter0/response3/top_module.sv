module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	parameter IDLE = 2'b00;
	parameter SEARCH_1 = 2'b01;
	parameter SEARCH_2 = 2'b10;
	parameter DONE = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (data == 1'b1)
						state <= SEARCH_1;
				end
				SEARCH_1: begin
					if (data == 1'b1)
						state <= SEARCH_2;
					else
						state <= IDLE;
				end
				SEARCH_2: begin
					if (data == 1'b0)
						state <= IDLE;
					else
						state <= DONE;
				end
				DONE: begin
					start_shifting <= 1;
					state <= DONE;
				end
			endcase
		end
	end
endmodule
