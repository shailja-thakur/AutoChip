module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);

	// States
	parameter INIT = 2'b00;
	parameter COUNT_ONES = 2'b01;
	parameter RESET_COUNT = 2'b10;

	reg [1:0] state;
	reg [2:0] count_ones;

	// Outputs
	assign disc = (state == COUNT_ONES) && (count_ones == 5);
	assign flag = (state == COUNT_ONES) && (count_ones == 6);
	assign err = (state == COUNT_ONES) && (count_ones >= 7);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= INIT;
			count_ones <= 3'b000;
		end else begin
			case (state)
				INIT: begin
					if (in) begin
						state <= COUNT_ONES;
						count_ones <= 3'b001;
					end
				end
				COUNT_ONES: begin
					if (in) begin
						if (count_ones == 3'b111) begin
							state <= RESET_COUNT;
						end else begin
							count_ones <= count_ones + 1;
						end
					end else if (!in) begin
						state <= INIT;
						count_ones <= 3'b000;
					end
				end
				RESET_COUNT: begin
					if (!in) begin
						state <= INIT;
						count_ones <= 3'b000;
					end
				end
			endcase
		end
	end
endmodule
