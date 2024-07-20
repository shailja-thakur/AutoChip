module top_module(
	input clk,
	input reset,
	input data,
	output reg start_shifting);

	reg [3:0] state;

	parameter IDLE = 2'b00;
	parameter SEARCH_1 = 2'b01;
	parameter SEARCH_2 = 2'b10;
	parameter MATCH = 2'b11;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= IDLE;
			start_shifting <= 0;
		end else begin
			case (state)
				IDLE: begin
					if (data) begin
						state <= SEARCH_1;
					end
				end

				SEARCH_1: begin
					if (data) begin
						state <= SEARCH_1;
					end else begin
						state <= SEARCH_2;
					end
				end

				SEARCH_2: begin
					if (data) begin
						state <= MATCH;
						start_shifting <= 1;
					end else begin
						state <= SEARCH_2;
					end
				end

				MATCH: begin
					if (reset) begin
						state <= IDLE;
						start_shifting <= 0;
					end
				end
			endcase
		end
	end
endmodule
